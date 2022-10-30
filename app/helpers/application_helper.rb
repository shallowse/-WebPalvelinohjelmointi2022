module ApplicationHelper
  def edit_and_destroy_buttons(item)
    return if current_user.nil?

    edit = link_to('Edit', url_for([:edit, item]), class: 'btn btn-primary col-sm-2 m-2')
    del = button_to('Destroy', item, method: :delete,
                                     form: { data: { turbo_confirm: 'Are you sure?' } },
                                     class: 'btn btn-danger col-sm-2')
    raw("<div class='row'>#{edit} #{del}</div>")
  end
end
