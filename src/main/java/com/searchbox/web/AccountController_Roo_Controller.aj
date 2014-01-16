// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.searchbox.web;

import com.searchbox.domain.Account;
import com.searchbox.web.AccountController;
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

privileged aspect AccountController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String AccountController.create(@Valid Account account, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, account);
            return "accounts/create";
        }
        uiModel.asMap().clear();
        account.persist();
        return "redirect:/accounts/" + encodeUrlPathSegment(account.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String AccountController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Account());
        return "accounts/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String AccountController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("account", Account.findAccount(id));
        uiModel.addAttribute("itemId", id);
        return "accounts/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String AccountController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("accounts", Account.findAccountEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) Account.countAccounts() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("accounts", Account.findAllAccounts(sortFieldName, sortOrder));
        }
        return "accounts/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String AccountController.update(@Valid Account account, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, account);
            return "accounts/update";
        }
        uiModel.asMap().clear();
        account.merge();
        return "redirect:/accounts/" + encodeUrlPathSegment(account.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String AccountController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Account.findAccount(id));
        return "accounts/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String AccountController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Account account = Account.findAccount(id);
        account.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/accounts";
    }
    
    void AccountController.populateEditForm(Model uiModel, Account account) {
        uiModel.addAttribute("account", account);
    }
    
    String AccountController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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
