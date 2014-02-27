package com.searchbox.framework.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.searchbox.framework.domain.CollectionDefinition;
import com.searchbox.framework.domain.SearchEngineDefinition;
import com.searchbox.framework.domain.Searchbox;
import com.searchbox.framework.repository.CollectionRepository;
import com.searchbox.framework.repository.SearchEngineRepository;
import com.searchbox.framework.repository.SearchboxRepository;

@Controller
@RequestMapping("/")
public class HomeController {
	
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	SearchboxRepository searchboxRepository;
	
	@Autowired
	CollectionRepository collectionRepository;
	
	@Autowired
	SearchEngineRepository searchEngineRepository;
	
	@ModelAttribute("collections")
	public List<CollectionDefinition> getAllCollections() {
		ArrayList<CollectionDefinition> list = new ArrayList<CollectionDefinition>();
		Iterator<CollectionDefinition> it = collectionRepository.findAll().iterator();
		while (it.hasNext()) {
			list.add(it.next());
		}
		return list;
	}	
	
	@ModelAttribute("searchengines")
	public List<SearchEngineDefinition> getAllSearchEngines() {
		ArrayList<SearchEngineDefinition> list = new ArrayList<SearchEngineDefinition>();
		Iterator<SearchEngineDefinition> it = searchEngineRepository.findAll().iterator();
		while (it.hasNext()) {
			list.add(it.next());
		}
		return list;
	}	
	
	@ModelAttribute("searchboxes")
	public List<Searchbox> getAllSearchboxes() {
		ArrayList<Searchbox> searchboxes = new ArrayList<Searchbox>();
		Iterator<Searchbox> sbx = searchboxRepository.findAll().iterator();
		while (sbx.hasNext()) {
			searchboxes.add(sbx.next());
		}
		return searchboxes;
	}	
	
	@RequestMapping()
	public ModelAndView search(
			HttpServletRequest request, ModelAndView model,
			RedirectAttributes redirectAttributes) {

		ModelAndView mav = new ModelAndView("index");
		return mav;
	}

}