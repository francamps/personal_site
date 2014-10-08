
module.exports = (env, callback) ->
  ### Paginator plugin. Defaults can be overridden in config.json
      e.g. "paginator": {"perPage": 10} ###
  
  defaults =
    template: 'nopatterns.jade' # template that renders pages
    articles: 'articles' # directory containing contents to paginate
    first: 'nopatterns/index.html' # filename/url for first page
    filename: 'nopatterns/page/%d/index.html' # filename for rest of pages
    perPage: 2 # number of articles per page

  #defaults_tech =
  #  template: 'patterns.jade' # template that renders pages
  #  articles: 'tech_articles' # directory containing contents to paginate
  #  first: 'patterns/index.html' # filename/url for first page
  #  filename: 'patterns/page/%d/index.html' # filename for rest of pages
  #  perPage: 2 # number of articles per page    

  # assign defaults any option not set in the config file
  options = env.config.paginator or {}
  for key, value of defaults
    options[key] ?= defaults[key]

  #options_tech = env.config.paginator_tech or {}
  #for key, value of defaults_tech
  #  options_tech[key] = defaults_tech[key]    

  getArticles = (contents) ->
    # helper that returns a list of articles found in *contents*
    # note that each article is assumed to have its own directory in the articles directory
    articles = contents[options.articles]._.directories.map (item) -> item.index
    articles.sort (a, b) -> b.date - a.date
    return articles

  #getTechArticles = (contents) ->
    # helper that returns a list of tech articles found in *contents*
    # note that each article is assumed to have its own directory in the articles directory
  #  articles = contents[options_tech.articles]._.directories.map (item) -> item.index
  #  articles.sort (a, b) -> b.date - a.date
  #  return articles    

  class PaginatorPage extends env.plugins.Page
    ### A page has a number and a list of articles ###

    constructor: (@pageNum, @articles) ->

    getFilename: ->
      if @pageNum is 1
        options.first
      else
        options.filename.replace '%d', @pageNum

    getView: -> (env, locals, contents, templates, callback) ->
      # simple view to pass articles and pagenum to the paginator template
      # note that this function returns a funciton

      # get the pagination template
      template = templates[options.template]
      if not template?
        return callback new Error "unknown paginator template '#{ options.template }'"

      # setup the template context
      ctx = {@articles, @prevPage, @nextPage}

      # extend the template context with the enviroment locals
      env.utils.extend ctx, locals

      # finally render the template
      template.render ctx, callback

  class TechPaginatorPage extends env.plugins.Page
    ### A page has a number and a list of articles ###

    constructor: (@pageNum, @articles) ->

    getFilename: ->
      if @pageNum is 1
        options_tech.first
      else
        options_tech.filename.replace '%d', @pageNum

    getView: -> (env, locals, contents, templates, callback) ->
      # simple view to pass articles and pagenum to the paginator template
      # note that this function returns a function

      # get the pagination template
      template = templates[options_tech.template]
      if not template?
        return callback new Error "unknown paginator template '#{ options.template }'"

      # setup the template context
      ctx = {@articles, @prevPage, @nextPage}

      # extend the template context with the enviroment locals
      env.utils.extend ctx, locals

      # finally render the template
      template.render ctx, callback      

  # register a generator, 'paginator' here is the content group generated content will belong to
  # i.e. contents._.paginator
  env.registerGenerator 'paginator', (contents, callback) ->

    # find all articles
    articles = getArticles contents

    # populate pages
    numPages = Math.ceil articles.length / options.perPage

    pages = []
    #for i in [0...numPages]
      #pageArticles = articles#.slice i * options.perPage, (i + 1) * options.perPage
      #pages.push new PaginatorPage i + 1, pageArticles
    pages.push new PaginatorPage 0, articles  

    # add references to prev/next to each page
    for page, i in pages
      page.prevPage = pages[i - 1]
      page.nextPage = pages[i + 1]

    # create the object that will be merged with the content tree (contents)
    # do _not_ modify the tree directly inside a generator, consider it read-only
    rv = {pages:{}}
    #for page in pages
      #rv.pages["#{ page.pageNum }.page"] = page # file extension is arbitrary
    rv['index.page'] = pages[0] # alias for first page

    # callback with the generated contents
    callback null, rv

  #env.registerGenerator 'paginator_tech', (contents, callback) ->
  
  # # find all articles
  # articles_tech = getTechArticles contents

  # # populate tech pages
  # numPages = Math.ceil articles_tech.length / options_tech.perPage
  # pages = []
  # #for i in [0...numPages]
  #   #pageArticles = articles_tech.slice i * options_tech.perPage, (i + 1) * options_tech.perPage
  #   #pages.push new TechPaginatorPage i + 1, pageArticles
  # pages.push new TechPaginatorPage 0, articles_tech

  # # add references to prev/next to each page
  # for page, i in pages
  #   page.prevPage = pages[i - 1]
  #   page.nextPage = pages[i + 1]

  # # create the object that will be merged with the content tree (contents)
  # # do _not_ modify the tree directly inside a generator, consider it read-only
  # rv = {pages:{}}
  # #for page in pages
  #   #rv.pages["#{ page.pageNum }.page"] = page # file extension is arbitrary
  # rv['index.page'] = pages[0] # alias for first page

  # # callback with the generated contents
  # callback null, rv    

  # add the article helper to the environment so we can use it later
  env.helpers.getArticles = getArticles
  #env.helpers.getTechArticles = getTechArticles

  # tell the plugin manager we are done
  callback()
