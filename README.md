# jekyll-tagger

jekyll plugin for generationg tag pages and feeds.

![logo.png](logo.png)

<div>  
  <a href="https://rubygems.org/gems/jekyll_tagger"><img src="https://img.shields.io/gem/v/jekyll_tagger.svg?maxAge=2592000&amp;style=plastic" alt="Version"></a>
  <a href="https://github.com/napuzba/jekyll_tagger"><img src="https://img.shields.io/github/watchers/napuzba/jekyll_tagger.svg??style=social&amp;label=watchers&amp;link=https://github.com/napuzba/jekyll_tagger&amp;style=social" alt="github"></a>
  <a href="https://travis-ci.org/napuzba/jekyll_tagger"><img src="http://img.shields.io/travis/napuzba/jekyll_tagger.svg?maxAge=2592000&amp;style=plastic" alt="Build Status"></a>
  <a href="https://github.com/napuzba/jekyll_tagger"><img src="https://img.shields.io/gem/dt/jekyll_tagger.svg?style=plastic" alt="Downloads"></a>
</div>

## Installing plugin

You can install the plugin using:

  ```
  $ gem install jekyll_tagger
  ```

Alternatively , If your Jekyll project using `bundle`, you may prefer to add it as dependency in your project `Gemfile`:

  ```
  gem 'jekyll_tagger'
  ```

Now, you should the gem to your `_config.yml`:

  ```
  gems: ['jekyll_tagger']
  ```

## Variables

The following provided to `feed` and `page` layouts:

|Variable| Description
|--------|------------
| `posts`    | the post of the current page
| `tag`      | the tag
| `tag_name` | the tag name
| `tag_slug` | the tag slug

The following will allow to build a pager on page layout:
  
|Variable| Description
|--------|------------
| `title`      | the title of the page
| `page_list`  | List of `PageInfo` to display
| `page_next`  | The `PageInfo` of next page
| `page_prev`  | The `PageInfo` of previous page
| `page_first` | The `PageInfo` of first page
| `page_last`  | The `PageInfo` of last page
| `page_curr`  | The page number

## Filters

The following filters can be used in layouts:

|Filter| Description
|--------|------------
|```{{ tag \| tag_name }}``` | Display the tag name
|```{{ tag \| tag_slug }}``` | Display the tag slug
|```{{ tag \| tag_url type: type [number: 1] }}``` | Display the url of tag's item. a number can be provided for `page` item.
|```{{ tag \| tag_link_page [html_opts:'']) }}``` |  Display a link to tag `page` item. html_opts is string which appended to the link.

## Configure Plugin

The way `jekyll_tagger` generate the tag pages and feeds can configured with the `tagger` key in your `_config.yml`.

  ```yaml
  tagger:
    # setting
  ```

## Active Tags - Including and Excluding Tags

The `active-tags` is list of tags for which the plugin will generate items.

By default, `active-tags` contains all the tags in the site. In other words, by default the plugin will generate items for all the tags in the site.

The following setting allows to set `active-tags` list to a subset of tags.

### include

The `include` is list of tags to include in the `active tags`. `[]` has special meaning - It notify the plugin to include all the tags in the site.

* The default value is `[]`

  ```yaml
  tagger:
    include: ['AA','BB'] # will generate items only for 'AA','BB' tags
  ```

  ```yaml
  tagger:
    include: []          # will generate items for all tags
  ```

### exclude

The `exclude` is a list of tags to exclude from `active-tags` after the plugin to include all the in `include` list.

* The default value is `[]`

  ```yaml
  tagger:
    exclude: ['AA','BB'] # will generate all tags excluding 'AA','BB'
  ```

  ```yaml
  tagger:
    include: ['AA','BB','CC']
    exclude: ['AA','BB','DD'] # will generate tags 'CC'
  ```

## Generating Items

Currently, The plugin can generate the following items:

 * `page` is the HTML page (or pages if pagination is enabled) using your page layout.
 * `feed` will generate the xml feeds using your feed layout.

By default both `page` and `feed` items will be generated. You can select only one item type to generate using `types` setting.

### types

`types` is a list of types. For each tag in `active-tags`, The plugin will generate all the items in this list.

* The default value is `['page','feed']`.

  ```yaml
  tagger:
    types: ['page','feed'] # will generate both page and feed
  ```

  ```yaml
  tagger:
    types: ['page']        # will generate page only
  ```

## Change the Tag's Name

The tag's name will be provided to layouts as `tag_name`. By default, the tag's name is the tag. You can change the name of the tag using `names` setting

### names

The `names` is a hash from tag to name. This hash is used to determine the name of a given tag. If the tag exists in the hash then the name will be its value, otherwise it will be the tag.

 * The default value is `{}`

  ```yaml
  tagger:
    names: { 'cpp': 'c++'}   # The name of cpp is c++
  ```

## Change the Tag's Slug

The tag's slug will be provided to layouts as `tag_slug`. It will also be used to generate the location of page and feed files. By default, the tag's slug is the tag. You can change the slug of the tag using `slugs` setting

### slugs

The `slugs` is a hash from tag to slug. This hash is used to determine the slug of a given tag. If the tag exists in the hash then the slug will be its value, otherwise it will be the tag.

 * The default value is `{}`

The tag's slug will be provided to layout as `tag_slug`.  By default, the tag's slug is the tag. You can change the slug of the tag using `slugs` setting

  * The default value is `{}`

  ```yaml
  tagger:
    slugs: { 'c++': 'cpp'}   # The slug of c++ is cpp
  ```

## Change the Item's Folder

The folder , the plugin will create the item, is based on based on its type (`page` or `feed`). By default, the folder is `tag`. You can change the folder of the tag using `folders` setting.

### folders

The `folders` is a hash from type to folder. This hash is used to determine the folder of a given type:

  * If the type exists in the hash then the folder will be its value
  * If the special type `*` exists in the hash then the folder will be its value
  * Otherwise , 'tag' will be used

  ```yaml
  tagger:
    folders: { 'feed': 'myfeed'}   # The folder for feed is myfeed, The folder for page is 'tag'
  ```

  ```yaml
  tagger:
    folders: { '*': 'mytags' }        # The folder for feed and page is mytags
  ```

## Change the Tag Item's Layout

The layout from which the plugin generate the page is based on the tag and its type and the `layouts` setting:

### layouts

The `folders` is a hash from type/tag to folder. This hash is used to determine the layout of a given tag for the given type:

 * If the `#{type}_#{tag}` exists in the hash then the layout will be its value
 * If the `#{type}`     exists in the hash then the layout will be its value
 * If the `*`        exists in the hash then the layout will be its value
 * If the layout `tag_#{type}_#{tag}` exists , then the layout will be used
 * If the layout `tag_#{type}` exists , then the layout will be used

  ```yaml
  tagger:
    include: ['AA','BB']
    layouts:
      - 'feed_AA' : layout1 # for feed of AA use 'layout1'
      - 'page_BB' : layout2 # for page of BB use 'layout2'
      # imply :
      #     for page of AA use 'tag_page_AA' if exists, otherwise use 'tag_page'
      #     for feed of BB use 'tag_feed_BB' if exists, otherwise use 'tag_feed'
  ```

  ```yaml
  tagger:
    include: ['AA','BB']
    layouts:
      - 'page_BB' : layout1 # for page of BB use 'layout1'
      - '*'       : layout2 # for all other items use 'layout2'
  ```

  ```yaml
  tagger:
    include: ['AA','BB']
    layouts:
      - 'feed' : layout1 # for feed items use 'layout1'
      # imply:
      #     for page of AA use 'tag_page_AA' if exists, otherwise use 'tag_page'
      #     for page of BB use 'tag_page_BB' if exists, otherwise use 'tag_page'
  ```

## Change the url style

The plugin support the following url styles:

  * The `pretty` style
   * for first page - `#{folder}/#{tag}/`
   * for other page - `#{folder}/#{tag}/page/#{number}`
   * for the feed   - `#{folder}/#{tag}/feed.xml`
  * The `simple` style
   * for first page - `#{folder}/#{tag}.html`
   * for other page - `#{folder}/#{tag}-#{number}.html`
   * for the feed   - `#{folder}/#{tag}.xml`

By default, the plugin will generate the items with `pretty` style. You can change this using `style` setting:

### style

  ```yaml
  tagger:
    style: simple
  ```

## Change the post order

The layout will be provided with the posts related to tag via `posts` list. By default the posts are ordered by descending order. You can change this using `post_order` setting:

### post order
  ```yaml
  tagger:
    post_order : ascending
  ```

## Add Index

The plugin support generate indexes by adding by `indexes` setting.

### indexes
The `indexes` list defines the indexes to generate.

The current valid index is '@' which means merge posts related to tag in `active-tag`.

  ```yaml
  tagger:
    indexes: ['@']       # generate index for all the posts in the site
  ```

  ```yaml
  tagger:
    include: ['AA','BB']
    indexes: ['@']       # generate index for all the posts of AA and BB
  ```

You can use the index control the properties of the index by adding it to 'names','slugs', 'folders' and 'layouts' as it where a tag.

  ```yaml
  tagger:
    indexes: ['@']                   # generate index for all the posts in the site
    names:   {'@':'My recent posts'} # The name of the index is 'My recent posts'
    folders: {'@':''}                # generate in the site root
  ```

## Adding Pagination

By default, only one page is generated to each tag. You can add pagination to the pages using `page_size` and `page_show` settings:

### page_size

The number of posts per page. By default, this value is 0 which means do not paginate the tags.

  ```yaml
  tagger:
    page_size: 5    # paginate with 5 post per page.
  ```


### page_show
The `page_show` defines how many `PageInfo` items wiil be in `page_list` provided to the page layout.

  ```yaml
  tagger:
    page_show: 5    # show 5 navigation PageInfo
  ```

## Adding a Pager to Tag Pages

In layout we can iterate over `page_list` to generate the pager. The `PageInfo` contains the following properties:

 * `url` - The page url
 * `number` - The page number
 * `selected` - Whether the current page is selected

The following will createa a simple pager:

## Example for simple pager

```
  <ul>
      {% if page.page_prev.valid %}
          <li><a href="{{ page.page_prev.url }}">&lt;</a></li>
      {% else %}
          <li><span>&lt;</span></li>
      {% endif %}

      {% for pp in page.page_list %}
          {% if    pp.selected %}
              <li><em>{{ pp.number }}</em></li>
          {% elsif pp.valid    %}
              <li><a href="{{pp.url}}">{{ pp.number }}</a></li>
          {% else              %}
              <li><span></span></li>
          {% endif %}
      {% endfor %}

      {% if page.page_next.valid %}
          <li><a href="{{ page.page_next.url }}">&gt;</a></li>
      {% else %}
          <li><span>&gt;</span></li>
      {% endif %}
  </ul>
```
