
module.exports = (env, callback) ->
  ### Paginator plugin. Defaults can be overridden in config.json
      e.g. "paginator": {"perPage": 10} ###
  
  defaults =
    template: 'archive.jade'                   # template that renders article archive
    # templateProjects: 'projects.jade'             # template that renders project archive
    articles: 'articles'                          # directory containing contents to paginate
    # projects: 'projects'                          # directory containing contents to paginate
    first: 'articles/index.html'                  # filename/url for first page
    filename: 'articles/page/%d/index.html'       # filename for rest of pages
    # proj_filename: 'projects/page/%d/index.html'
    perPage: 2                                    # number of articles per page

  # assign defaults any option not set in the config file
  options = env.config.paginator or {}
  for key, value of defaults
    options[key] ?= defaults[key]

  getArticles = (contents) ->
    # helper that returns a list of articles found in *contents*
    # note that each article is assumed to have its own directory in the articles directory
    articles = contents[options.articles]._.directories.map (item) -> item.index
    articles.sort (a, b) -> b.date - a.date
    return articles

  getProjects = (contents) ->
    # Returns a list of projects found in *contents*
    projects = contents[options.projects]._.directories.map (item) -> item.index
    projects.sort (a, b) -> b.date - a.date
    return projects

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

  # register a generator, 'paginator' here is the content group generated content will belong to
  # i.e. contents._.paginator
  env.registerGenerator 'paginator', (contents, callback) ->

    # find all articles
    articles = getArticles contents

    # find all projects
    # projects = getProjects contents

    # populate pages
    numPages = Math.ceil articles.length / options.perPage

    pages = []
    #projs = []

    pages.push new PaginatorPage 0, articles  
    #projs.push new PaginatorPage 0, projects

    # add references to prev/next to each page
    for page, i in pages
      page.prevPage = pages[i - 1]
      page.nextPage = pages[i + 1]

    #for proj, i in projs
    #  proj.prevPage = projs[i - 1]
    #  proj.nextPage = projs[i + 1]

    # create the object that will be merged with the content tree (contents)
    # do _not_ modify the tree directly inside a generator, consider it read-only
    rv = { pages:{} }
    #rvp = { projs:{} }

    #for page in pages
      #rv.pages["#{ page.pageNum }.page"] = page # file extension is arbitrary
    rv['index.page'] = pages[0] # alias for first page
    #rvp['index_project.page'] = projs[0] # alias for first page

    # callback with the generated contents
    callback null, rv

  # add the article helper to the environment so we can use it later
  env.helpers.getArticles = getArticles

  #env.helpers.getProject = getProjects

  # tell the plugin manager we are done
  callback()