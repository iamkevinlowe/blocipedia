module WikisHelper
  def private_icon(wiki)
    if wiki.private?
      "<span class='glyphicon glyphicon-lock'
      style='color: red; font-size: 0.6em;'>
      </span>".html_safe
    else
      ""
    end
  end

  def stripe_script
    "<script class='stripe-button' 
    src='https://checkout.stripe.com/checkout.js'
    data-key='<%= @stripe_btn_data[:key] %>'
    data-amount=<%= @stripe_btn_data[:amount] %>
    data-description='<%= @stripe_btn_data[:description] %>' >
    </script>".html_safe
  end
end
