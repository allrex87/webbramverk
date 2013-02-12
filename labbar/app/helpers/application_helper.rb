module ApplicationHelper

  def get_item_list (item, user)
    return item.where(["user_id = ?", user.id]).all
  end
  
  def get_item_list_limit item, user, limit
    return item.where(["user_id = ?", user.id]).last(limit)
  end
  
  def show_flash
    if flash.any?
      {:notice => 'notice', :alert => 'error', :error => 'error'}.each do |value, type|
        if flash[value].kind_of?(Array)
          return content_tag(:div, flash[value].join("<br>").html_safe, :class => "#{type}") 
        else
          return content_tag(:div, flash[value], :class => "#{type}") 
        end
      end
    else
      return content_tag(:div, "flash[:alert]", :class => "cp")
    end
    return content_tag(:div, "flash[:alert]", :class => "cp")
  end
  
end
