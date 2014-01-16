// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.searchbox.web;

import com.searchbox.domain.collection.SolrCloudCollection;
import com.searchbox.web.SolrCloudCollectionController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect SolrCloudCollectionController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String SolrCloudCollectionController.create(@Valid SolrCloudCollection solrCloudCollection, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, solrCloudCollection);
            return "solrcloudcollections/create";
        }
        uiModel.asMap().clear();
        solrCloudCollection.persist();
        return "redirect:/solrcloudcollections/" + encodeUrlPathSegment(solrCloudCollection.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String SolrCloudCollectionController.createForm(Model uiModel) {
        populateEditForm(uiModel, new SolrCloudCollection());
        return "solrcloudcollections/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String SolrCloudCollectionController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("solrcloudcollection", SolrCloudCollection.findSolrCloudCollection(id));
        uiModel.addAttribute("itemId", id);
        return "solrcloudcollections/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String SolrCloudCollectionController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("solrcloudcollections", SolrCloudCollection.findSolrCloudCollectionEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) SolrCloudCollection.countSolrCloudCollections() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("solrcloudcollections", SolrCloudCollection.findAllSolrCloudCollections(sortFieldName, sortOrder));
        }
        return "solrcloudcollections/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String SolrCloudCollectionController.update(@Valid SolrCloudCollection solrCloudCollection, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, solrCloudCollection);
            return "solrcloudcollections/update";
        }
        uiModel.asMap().clear();
        solrCloudCollection.merge();
        return "redirect:/solrcloudcollections/" + encodeUrlPathSegment(solrCloudCollection.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String SolrCloudCollectionController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, SolrCloudCollection.findSolrCloudCollection(id));
        return "solrcloudcollections/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String SolrCloudCollectionController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        SolrCloudCollection solrCloudCollection = SolrCloudCollection.findSolrCloudCollection(id);
        solrCloudCollection.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/solrcloudcollections";
    }
    
    void SolrCloudCollectionController.populateEditForm(Model uiModel, SolrCloudCollection solrCloudCollection) {
        uiModel.addAttribute("solrCloudCollection", solrCloudCollection);
    }
    
    String SolrCloudCollectionController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
