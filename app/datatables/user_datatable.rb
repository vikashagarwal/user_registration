# frozen_string_literal: true

class UserDatatable
  delegate :params, :h, :link_to, :image_tag, :edit_user_path, :user_path, to: :@view

  def initialize(view, current_user, _params)
    @view = view
    @is_super_admin = current_user.is_admin
  end

  def as_json(_options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: users.present? && users[0].present? ? users[0] : 0,
      iTotalDisplayRecords: users[1].present? ? users[1].total_entries : 0,
      aaData: users[1].present? ? data : []
    }
  end

  private

  def data
    users[1].map do |record|
      edit_link = link_to 'Edit', edit_user_path(record.id)
      link = link_to image_tag(record.profile_picture.url(:thumb), class: 'media-object'), record.profile_picture.url, target: '_blank'

      [
        record.name,
        record.email,
        record.address,
        record.phone_number,
        link,
        record.is_admin,
        edit_link,
      ]
    end
  end

  def users
    @fetch_users ||= fetch_users
  end

  def fetch_users
    users = User.all
    users = users.where('users.email like ?', "%#{params[:sSearch]}%") if params[:sSearch].present?
    users = users.order("#{sort_column} #{sort_direction}")
    [users.count, users.paginate(page: page, per_page: per_page)]
  rescue Exception => e
    [[], nil]
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 15
  end

  def sort_column
    columns = ["name", "email", "address", "phone_number"]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end

  def format_date(date)
    date.strftime('%d-%m-%Y') rescue ''
  end
end
