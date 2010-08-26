Typo::Application.routes.draw do
  match '/' => 'articles#index'
  match 'fm/filemanager/:action/:id' => 'Fm::Filemanager#index'
  match ':year/:month' => 'articles#index', :as => :articles_by_month, :month => /\d{1,2}/, :year => /\d{4}/
  match ':year/:month/page/:page' => 'articles#index', :as => :articles_by_month_page, :month => /\d{1,2}/, :year => /\d{4}/
  match ':year' => 'articles#index', :as => :articles_by_year, :year => /\d{4}/
  match ':year/page/:page' => 'articles#index', :as => :articles_by_year_page, :year => /\d{4}/
  match 'admin' => 'admin/dashboard#index', :as => :admin
  match 'articles.rss' => 'articles#index', :as => :rss, :format => 'rss'
  match 'articles.atom' => 'articles#index', :as => :atom, :format => 'atom'
  match 'articlerss/:id/feed.xml' => 'xml#articlerss', :as => :xml, :path_prefix => 'xml'
  match 'commentrss/feed.xml' => 'xml#commentrss', :as => :xml, :path_prefix => 'xml'
  match 'trackbackrss/feed.xml' => 'xml#trackbackrss', :as => :xml, :path_prefix => 'xml'
  match 'rss' => 'xml#feed', :as => :xml, :type => 'feed', :format => 'rss', :path_prefix => 'xml'
  match 'sitemap.xml' => 'xml#feed', :as => :xml, :type => 'sitemap', :format => 'googlesitemap', :path_prefix => 
  match ':format/feed.xml' => 'xml#feed', :as => :xml, :type => 'feed', :path_prefix => 'xml'
  match ':format/:type/feed.xml' => 'xml#feed', :as => :xml, :path_prefix => 'xml'
  match ':format/:type/:id/feed.xml' => 'xml#feed', :as => :xml, :path_prefix => 'xml'
  resources :comments do
    collection do
   :preview
  end
  
  
  end

  resources :trackbacks
  match '/live_search/' => 'articles#live_search', :as => :live_search_articles
  match '/search/:q.:format' => 'articles#search', :as => :search
  match '/search/' => 'articles#search', :as => :search_base
  match '/archives/' => 'articles#archives'
  match '/setup' => 'setup#index'
  match '/setup/confirm' => 'setup#confirm'
  match 'trackbacks/:id/:day/:month/:year' => 'trackbacks#create', :via => post
  resources :categories
  resources :categories
  match '/category/:id/page/:page' => 'categories#show'
  resources :tags
  resources :tags
  match '/tag/:id/page/:page' => 'tags#show'
  match '/tags/page/:page' => 'tags#index'
  match '/author/:id' => 'authors#show'
  match '/author/:id.:format' => 'authors#show', :as => :xml, :format => /rss|atom/
  match 'page/:page' => 'articles#index', :page => /\d+/
  match 'pages/*name' => 'articles#view_page', :via => get
  match 'stylesheets/theme/:filename' => 'theme#stylesheets', :via => get, :filename => /.*/
  match 'javascripts/theme/:filename' => 'theme#javascript', :via => , :filename => /.*/
  match 'images/theme/:filename' => 'theme#images', :via => , :filename => /.*/
  match 'theme/static_view_test' => 'theme#static_view_test', :via => 
  match 'plugins/filters/:filter/:public_action' => 'textfilter#public_action'
  match 'previews/:id' => 'articles#preview'
  match 'check_password' => 'articles#check_password'
  match 'accounts' => 'accounts#index'
  match 'accounts/:action' => 'accounts#index'
  match 'accounts/:action/:id' => 'accounts#index', :id => 
  match 'backend' => 'backend#index'
  match 'backend/:action' => 'backend#index'
  match 'backend/:action/:id' => 'backend#index', :id => 
  match 'files' => 'files#index'
  match 'files/:action' => 'files#index'
  match 'files/:action/:id' => 'files#index', :id => 
  match 'sidebar' => 'sidebar#index'
  match 'sidebar/:action' => 'sidebar#index'
  match 'sidebar/:action/:id' => 'sidebar#index', :id => 
  match 'textfilter' => 'textfilter#index'
  match 'textfilter/:action' => 'textfilter#index'
  match 'textfilter/:action/:id' => 'textfilter#index', :id => 
  match 'xml' => 'xml#index'
  match 'xml/:action' => 'xml#index'
  match 'xml/:action/:id' => 'xml#index', :id => 
  match '/admin/advanced' => 'admin/advanced#index'
  match '/admin/advanced/:action/:id' => 'admin/advanced#index', :id => 
  match '/admin/cache' => 'admin/cache#index'
  match '/admin/cache/:action/:id' => 'admin/cache#index', :id => 
  match '/admin/categories' => 'admin/categories#index'
  match '/admin/categories/:action/:id' => 'admin/categories#index', :id => 
  match '/admin/comments' => 'admin/comments#index'
  match '/admin/comments/:action/:id' => 'admin/comments#index', :id => 
  match '/admin/content' => 'admin/content#index'
  match '/admin/content/:action/:id' => 'admin/content#index', :id => 
  match '/admin/profiles' => 'admin/profiles#index'
  match '/admin/profiles/:action/:id' => 'admin/profiles#index', :id => 
  match '/admin/feedback' => 'admin/feedback#index'
  match '/admin/feedback/:action/:id' => 'admin/feedback#index', :id => 
  match '/admin/general' => 'admin/general#index'
  match '/admin/general/:action/:id' => 'admin/general#index', :id => 
  match '/admin/pages' => 'admin/pages#index'
  match '/admin/pages/:action/:id' => 'admin/pages#index', :id => 
  match '/admin/resources' => 'admin/resources#index'
  match '/admin/resources/:action/:id' => 'admin/resources#index', :id => 
  match '/admin/sidebar' => 'admin/sidebar#index'
  match '/admin/sidebar/:action/:id' => 'admin/sidebar#index', :id => 
  match '/admin/textfilters' => 'admin/textfilters#index'
  match '/admin/textfilters/:action/:id' => 'admin/textfilters#index', :id => 
  match '/admin/themes' => 'admin/themes#index'
  match '/admin/themes/:action/:id' => 'admin/themes#index', :id => 
  match '/admin/trackbacks' => 'admin/trackbacks#index'
  match '/admin/trackbacks/:action/:id' => 'admin/trackbacks#index', :id => 
  match '/admin/users' => 'admin/users#index'
  match '/admin/users/:action/:id' => 'admin/users#index', :id => 
  match '/admin/settings' => 'admin/settings#index'
  match '/admin/settings/:action/:id' => 'admin/settings#index', :id => 
  match '/admin/tags' => 'admin/tags#index'
  match '/admin/tags/:action/:id' => 'admin/tags#index', :id => 
  match '*from' => 'articles#redirect'
  match '/:controller(/:action(/:id))'
end
