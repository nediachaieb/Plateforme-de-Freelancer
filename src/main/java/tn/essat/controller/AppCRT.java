package tn.essat.controller;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile; // Pour gérer les fichiers envoyés via le formulaire
import java.io.IOException; // Pour gérer les exceptions d'entrée/sortie
import java.nio.file.Files; // Pour travailler avec les fichiers
import java.nio.file.Path; // Représente un chemin vers un fichier ou un dossier
import java.nio.file.Paths; // Utilitaire pour créer des objets Path
import java.nio.file.StandardCopyOption; // Pour spécifier l'option de copie de fichiers

import tn.essat.dao.IMessage;
import tn.essat.dao.IProfil;
import tn.essat.dao.IProject;
import tn.essat.dao.IProposition;
import tn.essat.dao.IRole;
import tn.essat.dao.IUser;
import tn.essat.model.Message;
import tn.essat.model.Profil;
import tn.essat.model.Project;
import tn.essat.model.Proposition;
import tn.essat.model.Role;
import tn.essat.model.User;

@Controller
public class AppCRT {

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	IProject dao_project;
	@Autowired
	IUser dao_user;
	@Autowired
	IProposition dao_proposition;
	@Autowired
	IMessage dao_msg;
	@Autowired
	IProfil dao_profil;
	@Autowired
	IRole dao_role;

	@RequestMapping(value = "/login", method = { RequestMethod.POST, RequestMethod.GET })
	public String handleLogin(@RequestParam(value = "error", required = false) String error, Model model) {
		String msg = null;
		if (error != null) {
			msg = "Username or Password is incorrect !!";
		}
		model.addAttribute("errorMessge", msg);
		return "login";
	}

	@GetMapping("/registerFreelancer")
	public String RegistrationFormF(Model m) {
		User user = new User();
		m.addAttribute("user", user);
		return "inscriptionFreelancer";

	}

	@GetMapping("/registerClient")
	public String RegistrationFormC(Model m) {
		User user = new User();
		m.addAttribute("user", user);
		return "inscriptionClient";

	}

	@PostMapping("/saveFreelancer")
	public String registerFreelancer(Model m, @ModelAttribute User user) {
		Role freelancerRole = dao_role.findByRole("FREELANCER");
		user.setRole(freelancerRole);
		user.setEnabled(true);
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		dao_user.save(user);
		return "redirect:/login";

	}

	@PostMapping("/saveClient")
	public String registerClient(Model m, @ModelAttribute User user) {

		Role clientRole = dao_role.findByRole("CLIENT");
		user.setRole(clientRole);
		user.setEnabled(true);
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		dao_user.save(user);
		return "redirect:/login";
	}
	
	// ******Home******

	@GetMapping("/")
	public String getHome(Model m) {
		List<Project> projs = dao_project.findAll();
		m.addAttribute("projs", projs);
		return "Home";

	}
	
	// ***********creation projet **********
	
	@GetMapping("/addProject")
	public String addProjectForm(Model m) {
		Project project = new Project();
		m.addAttribute("project", project);
		return "addProject";
	}

	@PostMapping("/saveProject")
	public String saveProject(Model m, @ModelAttribute Project project) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User u = (User) auth.getPrincipal();
		project.setClient(u);
		dao_project.save(project);
		return "redirect:/";
	}

	

   //  *****************les projets proposés par les clients **********
	
	@GetMapping("/projClients")
	public String listAvailableProjects(Model model) {
		
		List<Project> projects = dao_project.findAllByClientRole("CLIENT");
		model.addAttribute("projects", projects);
		return "listproject";
	}

	@GetMapping("/detail_project/{id}")
	public String getProjectById(Model m, @PathVariable int id) {

		 Optional<Project> proj = dao_project.findById(id);
		    if (proj.isPresent()) {
		        m.addAttribute("proj", proj.get());
		        
		        // Récupérer l'utilisateur connecté
		        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		        User u = (User) auth.getPrincipal();

		        // Vérifier le rôle de l'utilisateur
		        boolean isFreelancer = u.getRole().getRole().equalsIgnoreCase("FREELANCER");
		        m.addAttribute("isFreelancer", isFreelancer);

		        // Si l'utilisateur est un freelancer, préparer une proposition
		        if (isFreelancer) {
		            Proposition p = new Proposition();
		            p.setProj(proj.get());
		            p.setFreelancer(u);
		            m.addAttribute("prp", p);
		        }

		        return "detailProject";
		    } else {
		        m.addAttribute("errorMessage", "Projet introuvable !");
		        return "error";
		    }
		}


	@GetMapping("/projects/client/{id}")
	public String getProjectsClients(Model m, @PathVariable int id, Principal principal) {
		if (principal == null) {
			return "redirect:/login";
		}
		List<Project> ProjC = dao_project.findByClientId(id);
		if (ProjC == null || ProjC.isEmpty()) {
			m.addAttribute("message", "Aucun projet trouvé.");
		}

		m.addAttribute("ProjC", ProjC);
		return "projectsClients";
	}
	
	@GetMapping("/deleteprojects/{id}")
	public String deleteprojects(Model m, @PathVariable("id") int id) {
		dao_project.deleteById(id);
	    return "redirect:/";
	}
//  *****************les projets faites par les Freelances **********
	@GetMapping("/projects/Freelances/{id}")
	public String getProjectsFreelancers(Model m, @PathVariable int id, Principal principal) {
		if (principal == null) {
			return "redirect:/login";
		}
		List<Project> ProjF = dao_project.findByClientId(id);
		if (ProjF == null || ProjF.isEmpty()) {
			m.addAttribute("message", "Aucun projet trouvé.");
		}

		m.addAttribute("ProjF", ProjF);
		return "projectsFreelances";
	}
	//*************************Proposition*************
	
	@PostMapping("/saveProposition")
	public String saveProposition(Model m, @ModelAttribute Proposition prp,RedirectAttributes redirectAttrs) {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User u = (User) auth.getPrincipal();
		if (!u.getRole().getRole().equals("FREELANCER")) {
	        throw new AccessDeniedException("Vous n'êtes pas autorisé à postuler.");
	    }
		prp.setFreelancer(u);
		prp.setProj(prp.getProj());
		dao_proposition.save(prp);
		redirectAttrs.addFlashAttribute("successMessage", "Votre proposition a été soumise avec succès !");
		return "redirect:/projClients";
	}

	@GetMapping("/propositions/projet/{id}")
	public String getpropositionsByproj(Model m, @PathVariable int id) {
		List<Proposition> propositions = dao_proposition.findByProjId(id);
		m.addAttribute("propositions", propositions);
		return "propositions";
	}
	
	@GetMapping("/clientProposition")
	public String getClientProjects(Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User u = (User) auth.getPrincipal();
		if (u == null || u.getId() == null) {
	     
	        return "redirect:/login";  
	    }

	    // Utilise l'ID de l'utilisateur pour récupérer ses projets
	    List<Project> clientProjects = dao_project.findProjectsByClientId(u.getId());
	    
	    model.addAttribute("clientProjects", clientProjects);
	    return "clientPropositions"; 
	}
	
	//*************************profil*************

	@GetMapping("/addProfil")
	public String addProfilForm(Model m) {
		Profil prf = new Profil();
		m.addAttribute("prf", prf);
		return "addProfil";
	}

	@PostMapping("/saveProfil")
	public String saveProfil(@ModelAttribute Profil prf, Model m) {

		dao_profil.save(prf);
		return "redirect:/profil";
	}

	@GetMapping("/profil/{id}")
	public String viewProfil(@PathVariable int id, Model m) {
	    Optional<Profil> prf = dao_profil.findById(id);
	    
	    if (prf.isPresent()) {
	        m.addAttribute("prf", prf.get());
	        List<Project> ProjF = dao_project.findByClientId(id);
	        
	        if (ProjF == null || ProjF.isEmpty()) {
	            m.addAttribute("message", "Aucun projet trouvé.");
	        }

	        m.addAttribute("ProjF", ProjF);
	        
	        return "viewProfil";  // Si le profil existe, on l'affiche
	    } else {
	        m.addAttribute("message", "Aucun profil trouvé. Veuillez créer un profil.");
	        return "redirect:/addProfil";  // Sinon on redirige vers la page de création
	    }
	}

	
	// ***************messages *************
	
	 @GetMapping("/messagesrecus")
	 public String getMessagesRecus(Model model, Principal principal) {
	     if (principal == null) {
	         return "redirect:/login";
	     }

	     // Récupérer l'utilisateur connecté
	     User currentUser = dao_user.findByUsername(principal.getName());
	     List<Message> msgs = dao_msg.findByUserreceiveId(currentUser.getId());

	     model.addAttribute("msgs", msgs); 
	     return "messagesRecus"; 
	 }
	 @GetMapping("/messagesenvoyes")
	 public String getMessagesEnvoyes(Model model, Principal principal) {
	     if (principal == null) {
	         return "redirect:/login";
	     }

	     // Récupérer l'utilisateur connecté
	     User currentUser = dao_user.findByUsername(principal.getName());

	     // Récupérer les messages envoyés par l'utilisateur connecté
	     List<Message> messagesEnvoyes = dao_msg.findByUsersendId(currentUser.getId());

	     model.addAttribute("messagesEnvoyes", messagesEnvoyes);
	     return "messagesEnvoyes";  
	 }

	 // ***********Création d'un message**********
	    @GetMapping("/addMessage")
	    public String addMessageForm(Model m) {
	        Message message = new Message();
	        List<User> users = dao_user.findAll();
	        m.addAttribute("users", users);
	        m.addAttribute("message", message); 
	        return "addMessage"; 
	    }

	    @PostMapping("/saveMessage")
	    public String saveMessage(Model m, @ModelAttribute Message message) {
	        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        User user = (User) auth.getPrincipal(); 
	        message.setUsersend(user); 
	        dao_msg.save(message); 
	        return "redirect:/messagesenvoyes" ;
	    }
	    

	    @GetMapping("/viewMessage")
	    public String viewMessage(@RequestParam("id") Integer id, Model model) {
	        Optional<Message> optionalMessage = dao_msg.findById(id);

	        if (optionalMessage.isPresent()) {
	            model.addAttribute("message", optionalMessage.get());
	            return "viewMessage"; // Vue JSP pour afficher les détails du message
	        } else {
	            model.addAttribute("error", "Message introuvable.");
	            return "redirect:/messagesenvoyes"; // Redirige vers la liste si le message est introuvable
	        }
	    }

	    // Delete a message
	    @GetMapping("/deleteMessage")
	    public String deleteMessage(@RequestParam("id") Integer id, Principal principal) {
	        Optional<Message> optionalMessage = dao_msg.findById(id);

	        if (optionalMessage.isPresent()) {
	            // Vérifier si l'utilisateur est l'expéditeur du message
	            User currentUser = dao_user.findByUsername(principal.getName());
	            if (optionalMessage.get().getUsersend().getId().equals(currentUser.getId())) {
	                dao_msg.deleteById(id);
	            } else {
	                // Ajoutez un message d'erreur si l'utilisateur n'est pas autorisé
	                return "redirect:/messagesenvoyes?error=unauthorized";
	            }
	        }

	        return "redirect:/messagesenvoyes"; // Retourne à la liste après suppression
	    }


}
