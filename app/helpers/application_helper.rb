# frozen_string_literal: true

module ApplicationHelper
  def title
    @page_title = t("title.#{controller.controller_name}.#{controller.action_name}", default: '') if @page_title.nil?
    if @page_title.empty?
      t('title.base')
    else
      @page_title + ' | ' + t('title.base')
    end
  end

  def title_variable(title)
    @page_title = title
  end
end
