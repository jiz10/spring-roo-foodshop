// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ar.com.edu.um.web;

import ar.com.edu.um.domain.Negocio;
import ar.com.edu.um.domain.Tag;
import ar.com.edu.um.web.NegocioController;
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

privileged aspect NegocioController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String NegocioController.create(@Valid Negocio negocio, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, negocio);
            return "negocios/create";
        }
        uiModel.asMap().clear();
        negocio.persist();
        return "redirect:/negocios/" + encodeUrlPathSegment(negocio.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String NegocioController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Negocio());
        return "negocios/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String NegocioController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("negocio", Negocio.findNegocio(id));
        uiModel.addAttribute("itemId", id);
        return "negocios/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String NegocioController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("negocios", Negocio.findNegocioEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) Negocio.countNegocios() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("negocios", Negocio.findAllNegocios(sortFieldName, sortOrder));
        }
        return "negocios/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String NegocioController.update(@Valid Negocio negocio, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, negocio);
            return "negocios/update";
        }
        uiModel.asMap().clear();
        negocio.merge();
        return "redirect:/negocios/" + encodeUrlPathSegment(negocio.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String NegocioController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Negocio.findNegocio(id));
        return "negocios/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String NegocioController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Negocio negocio = Negocio.findNegocio(id);
        negocio.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/negocios";
    }
    
    void NegocioController.populateEditForm(Model uiModel, Negocio negocio) {
        uiModel.addAttribute("negocio", negocio);
        uiModel.addAttribute("tags", Tag.findAllTags());
    }
    
    String NegocioController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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
