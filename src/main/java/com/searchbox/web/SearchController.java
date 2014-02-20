package com.searchbox.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.ConversionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.searchbox.WebConfig;
import com.searchbox.app.domain.PresetDefinition;
import com.searchbox.app.domain.Searchbox;
import com.searchbox.app.repository.PresetDefinitionRepository;
import com.searchbox.app.repository.SearchboxRepository;
import com.searchbox.service.SearchService;

@Controller
public class SearchController {

	private static Logger logger = LoggerFactory.getLogger(SearchController.class);

	@Autowired
	ConversionService conversionService;
	
	@Autowired
	ApplicationConversionService searchComponentService;
	
	@Autowired
	SearchService searchService;
	
	@Autowired
	SearchboxRepository searchboxRepository;
	
	@Autowired
	PresetDefinitionRepository	presetDefinitionRepository;
	
	public SearchController() {
	}
	
	@ModelAttribute("searchboxes")
	public List<Searchbox> getAllSearchboxes(){
		ArrayList<Searchbox> searchboxes = new ArrayList<Searchbox>();
		Iterator<Searchbox> sbx = searchboxRepository.findAll().iterator();
		while(sbx.hasNext()){
			searchboxes.add(sbx.next());
		}
		return searchboxes;
	}
	
	private ModelAndView executeSearch(Searchbox searchbox, PresetDefinition preset,
			 HttpServletRequest request, ModelAndView model){
		
		model.setViewName("search/index");
		
		if(searchbox == null){
			logger.info("Current searchbox is null...");
		} else {
			logger.info("we're in searchbox: " + searchbox.getName());
		}
		
		if(preset == null){
			logger.info("Current preset is null...");
		} else {
			logger.info("we're in preset: " + preset.getLabel());
		}
		
		for(Entry<String, Object> elem:model.getModelMap().entrySet()){
			logger.info("in model: " + elem.getKey() + " value: " + elem.getValue());
		}
		
		logger.info("No Slug given, select default Preset");
		return model;
	}
	
	@RequestMapping("/{slug}")
	public ModelAndView searchPreset(@RequestParam(value="searchbox", required = false) Searchbox searchbox,
			@PathVariable String slug,
			@ModelAttribute("searchboxes") ArrayList<Searchbox> searchboxes, 
			HttpServletRequest request, ModelAndView model) {
			
		PresetDefinition pdef = presetDefinitionRepository.findPresetDefinitionBySearchboxAndSlug(searchbox, slug);
		
		return this.executeSearch(searchbox, pdef, request, model);
	}
	
	@RequestMapping("/")
	public ModelAndView search(@RequestParam(value="searchbox", required = false) Searchbox searchbox,
			@RequestParam(value="preset", required = false) String slug,
			@ModelAttribute("searchboxes") ArrayList<Searchbox> searchboxes, 
			HttpServletRequest request, ModelAndView model) {

		PresetDefinition pdef = presetDefinitionRepository.findPresetDefinitionBySearchboxAndSlug(searchbox, slug);

		return this.executeSearch(searchbox, pdef, request, model);
	}

	
	
//	@RequestMapping("/{presetSlug}")
////	public ModelAndView search(@RequestParam("ff") FieldFacet.ValueCondition condition) {
//	public ModelAndView search(@RequestParam(value="searchbox", required=false) String searchboxSlug, 
//			@PathVariable String presetSlug, HttpServletRequest request) {
//		
//		//That should come from the searchbox param/filter
//		Iterator<Searchbox> searchboxes = searchboxRepository.findAll().iterator();
//		Searchbox searchbox = null;
//		while(searchboxes.hasNext()){
//			Searchbox sb = searchboxes.next();
//			if(sb.getSlug().equals(searchboxSlug)){
//				searchbox = sb;
//			}
//		}
//		
//		if(searchbox == null){
//			ModelAndView model = new ModelAndView("search/searchbox");
//			model.addObject("searchboxes",searchboxes);
//			return model;
//		}
//		
//		
//		List<Preset> presets = new ArrayList<Preset>();
//		Preset currentPreset = null;
//		for(PresetDefinition pdef:searchbox.getPresets()){
//			Preset pset = pdef.toPreset(new Preset());
//			
//			if(pset.getSlug().equals(presetSlug)){
//				currentPreset = pset;
//			}
//			presets.add(pset);
//		}
//		
//		if(currentPreset == null && presets.size() > 0){
//			currentPreset = presets.get(0);
//		}
//					
//		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
//		
//		for(String param:searchComponentService.getSearchConditionParams()){
//			if(request.getParameterValues(param) != null){
//				for(String value:request.getParameterValues(param)){
//					if(value != null && !value.isEmpty()){
//						try {
//						SearchCondition cond = (SearchCondition) conversionService.convert(value, searchComponentService.getSearchConditionClass(param));
//						conditions.add(cond);
//						} catch (Exception e) {
//							logger.error("Could not convert " + value, e);
//						}
//					}
//				}
//			}
//		}
//		
//		SearchResult result = new SearchResult();
//		
//		if(currentPreset != null){
//			for(SearchElement element:searchService.execute(currentPreset, conditions)){
//				logger.debug("Adding to result view element["+element.getPosition()+ "] = " + element.getLabel());
//				result.addElement(element);
//			}
//		}
//		
//		ModelAndView model = new ModelAndView("search/index");
//		model.addObject("result", result);
//		model.addObject("presets",presets);
//		model.addObject("searchboxes",searchboxes);
//		model.addObject("currentSearchbox",searchbox);
//		model.addObject("currentPreset", currentPreset);
//		
//		return model;
//	}
}
