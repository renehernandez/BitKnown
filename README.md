## Intro

BitKnown is a very simple fork of the [Odin](https://github.com/h4t0n/odin) theme.

## Features

* Clean style (without right side menu)  
* Works with Ghost upto version 1.8.5 (tested), but it should work with higher versions as well  
* Fully responsive (for mobiles and tablets)  
* Include Bootstrap framework  
* Include MathJax for math writing  
* Home Page Navigation Menu Buttons  
* Google Analytics (easily configurable by code injection in the admin area)  
* Disqus comments (easily configurable by code injection in the admin area)  
* Prism Syntax Highlight (all languages supported)  
* RRSSB Extraordinary Social Sharing Buttons  
* Font Awesome home page Social Link Icons (easily configurable by code injection in the admin area)  

I've forked and made changes on this theme for my personal blog at [bitsofknowledge](https://bitsofknowledge.net).

## Installation

Installation is the same as other themes, so clone or download the content of this repo inside your Ghost content/themes/ folder.

```
# for example
$ cd /your-ghost-root-directory
$ git clone https://github.com/renehernandez/BitKnown.git content/themes/BitKnown
```
Restart Ghost and select BitKnown theme from your Admin Area.

## Configuration

No need to configure Prism or RRSSB buttons.

To add Homepage Navigation Menu Buttons simply add the links in your Navigation Admin Area. They may be useful for static pages (AboutMe for example) or for shortcut to your (best) post tags.

BitKnown comes with a default favicon generated with Real Favicon Generator. If you want to add your favicon you can generate your own (with Real Favicon Generator) and place downloaded files inside the assets/img/favicons BitKnown directory.

Disqus comments, Google Analytics and Font Awesome Home Page Social Link Icons are disabled by default, but they are easily configurable with Blog Header Code Injection inside your Ghost Admin Area.

```
<script>
// to enable Google Analytics
var ga_id = 'YOUR-UA-ID_HERE';

// to enable Disqus
var disqus_shortname = 'YOUR_DISQUS_SHORTNAME'


// to enable Social Link Icons add the social_link object
// with the pair key/value -> social_network/link
// NB: the key is used to include the right icon from Font Awesome
// (you can include any Font Awesome icon)

// Example1: default social network icons
var social_link = {
    'twitter': 'twitter_url',
    'linkedin': 'linkedin_url',
    'github': 'github_url',
    'rss':'your_rss_feed'
    // you can add more icons
}

// Example2: squared social network icons
var social_link = {
    'twitter-square': 'twitter_url',
    'linkedin-square': 'linkedin_url',
    'github-square': 'github_url',
    'rss':'your_rss_feed'
    // you can add more icons
}

</script>
```

## Copyright & License

Released under the MIT License.  
Copyright (C) 2017 Rene Hernandez for (for BitKnown theme modifications)
Copyright (c) 2016 Andrea Tarquini aka @h4ton (for Odin theme substantial portions of code)
