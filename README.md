# activeadmin-dropzone [![Gem Version](https://badge.fury.io/rb/activeadmin-dropzone.png)](http://badge.fury.io/rb/activeadmin-dropzone)

Easy to use integration of drag&drop files upload via [dropzone.js](http://www.dropzonejs.com) for [ActiveAdmin](http://www.activeadmin.info).

## Requirements

* [ActiveAdmin](http://www.activeadmin.info);
* [Paperclip](https://github.com/thoughtbot/paperclip) gem;
* ActiveRecord;
* Separate models for file's container and files.

## Install

Add line to your Gemfile:

    gem 'activeadmin-dropzone', '~> 0.2.1'

Add `dropzone` to your file container's class: 

    class Post
        dropzone :images
    end

Add `dropzone_item` to your file's class:

    class Image
        dropzone_item
    end

Add `input` to your ActiveAdmin form:

    f.input :images, as: :dropzone
 
Add `activeadmin-dropzone` to both `active_admin.js` and `active_admin.css` files:

    //= require activeadmin-dropzone

## Configuration

You can customize columns used for upload by passing `Hash` to the `dropzone_item` method. Here are the default values:

    dropzone_item title: :title, 
                  position: :position, 
                  data: :data, 
                  file_size: :data_file_size, 
                  url: :data_url

## Contributing to activeadmin-dropzone
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Maxim Gladkov. See LICENSE.txt for
further details.
