module WrappedButton
  def wrapped_button(*args, &block)
    template.content_tag :div, :class => "form-actions" do
      options = args.extract_options!
      loading = self.object.new_record? ? I18n.t('simple_form.creating') : I18n.t('simple_form.updating')
      options[:"data-loading-text"] = [loading, options[:"data-loading-text"]].compact
      options[:class] = ['btn-primary', options[:class]].compact
      args << options
      cancel = (options.key?(:cancel) ? options.delete(:cancel) : :back)
      if cancel
        submit(*args, &block) + ' ' + I18n.t('simple_form.buttons.or') + ' ' + template.link_to(I18n.t('simple_form.buttons.cancel'), cancel, :class => 'btn')
      else
        submit(*args, &block)
      end
    end
  end
end
SimpleForm::FormBuilder.send :include, WrappedButton