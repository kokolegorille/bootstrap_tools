# BootstrapTools

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'bootstrap_tools'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bootstrap_tools

After install, include corresponding css by adding to manifest file app/assets/application.css

 *= require bootstrap_tools


## Usage

Here is the list of helpers methods

* render_menu menu
sample usage:
    render_menu [
      { caption: "Menu1", path: "" },
      { caption: "Menu2", menus: [
        {caption: "Sub1", menus: [
          { caption: "SubSub1", path: "" },
          { caption: "SubSub2", path: "" }
        ]}
      ]}
    ]

* render_dropdown links, options = {}

* activation_bar_for user

* objectmenu *args

you might overwrite additional_link_for in hosting application

* render_carousel(banners)

pass an array of images that respond to url(:fixed)

* modal

call the action with remote: true
add js response to controller
add js template, that contains...

  $('#myModal h3').html("<%= @upload %>");
  $('.modal-body').html('<%= escape_javascript(render(partial: 'uploads/show', locals: {upload: @upload} )) %>');
  $('#myModal').modal("show");

* render_breadcrumbs(items)

pass an array of links

## Contributing

1. Fork it ( https://github.com/[my-github-username]/bootstrap_tools/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
