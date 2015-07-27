module BootstrapTools
  module Helpers
        
    def render_menu menu
      return unless menu.present?
      render partial: "application/menu", locals: { menu: menu }
    end
    
    def render_dropdown(links, options = {})
      return unless links.present?
      render partial: "application/dropdown", locals: { links: links, css_style: dropdown_style(options[:mode]) }
    end
    
    def render_breadcrumbs(items)
      render partial: "application/breadcrumbs", locals: { items: items }
    end
    
    # each banner needs to respond_to url(:fixed)
    def render_carousel(banners)
      return unless banners.present?
      render partial: "application/carousel", locals: { banners: banners }
    end
    
    def objectmenu(*args)
      if (args[0].blank? || args[0].is_a?(Hash))
        object, options = nil, (args[0] || {})
      else
        object, options = args[0], (args[1] || {})
      end
    
      links = if object.present?  
        links_for_member(object, options)
      else
        links_for_collection(
          "#{ self.controller_name.classify }".constantize, 
          options)
      end
    
      links += options[:additional_links] if options[:additional_links].present?
      links += additional_link_for(object) if additional_link_for(object)
    
      render_dropdown(links, options)
    end
    
    # SORTABLE
    #
    # Model should responds_to :pseudo_id!
    #
    def sortable_list(collection, url, options = {}, &block)
      css_id = options[:css_id] ||= collection.first.class.to_s.demodulize.tableize
      link_block = block_given? ? block : ->(item) { item }
      render partial: "application/sortable_list", locals: { collection: collection, css_id: css_id, url: url, link_block: link_block }
    end
    
    # Overwrite to customize objectmenu
    def additional_link_for(object)
    end
    
    def activation_bar_for(user)
      if user.enabled
        link_to t(:"common.disable"), 
          disable_user_path(id: user), 
          method: :delete, 
          data: { confirm: t(:"common.are_you_sure") }
      else
        link_to t(:"common.enable"), 
          enable_user_path(id: user), 
          method: :patch
      end
    end
    
    private
    def dropdown_style(mode = :inside_nav)
      css_style = {
        button_group_class: "btn-group",
        button_class: "btn dropdown-toggle"
      }
      case mode.to_s
      when 'outside_nav'
        css_style[:button_group_class] << " floatRight"
      when 'in_table'
        css_style[:button_class] << " btn-xs"
      else
        css_style[:button_group_class] << " navbar-right"
        css_style[:button_class] << " navbar-btn"
      end
      css_style
    end
    
    def links_for_member(object, options = {})
      path = options[:parent].present? ? [options[:parent], object] : object
    
      result = []
      unless options[:no_edit]
        result << if options[:no_turbolink]
          link_to(
            t(:"common.edit"), 
            edit_polymorphic_path(path), 
            'data-no-turbolink' => true)
        else
          link_to(
            t(:"common.edit"), 
            edit_polymorphic_path(path))
        end
      end
    
      unless options[:no_delete]
        result << link_to(t(:"common.delete"), polymorphic_path(path), method: :delete, data: { confirm: t(:"common.are_you_sure") }) 
      end
      result
    end
  
    def links_for_collection(klass, options = {})
      path = options[:parent].present? ? [options[:parent], klass] : klass
    
      result = []
      unless options[:no_add]
        result << if options[:no_turbolink]
          link_to(
            t(:"common.add"), 
            new_polymorphic_path(path), 
            'data-no-turbolink' => true)
        else
          link_to(
            t(:"common.add"), 
            new_polymorphic_path(path))
        end
      end
      result
    end
    
  end # End module
end