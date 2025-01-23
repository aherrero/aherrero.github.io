---
layout: post
title: Blog based on Jekyll and Minima theme
date: 2025-01-23 08:00 +0200
categories: blog web ruby
comments: true
---


# Introduction
These are the quick steps to create this blog, in order to use the *dark theme* in the [minima jekyll theme](https://github.com/jekyll/minima)

# Basic installation
After install the [requirements](https://jekyllrb.com/docs/installation/windows/), follow the guide from [jekyll](https://jekyllrb.com/docs/)

```
gem install jekyll bundler
jekyll new myblog
cd myblog
bundle exec jekyll serve
```

And go to the browser,
[http://localhost:4000](http://localhost:4000)

# Configuration
There is a list of themes supported with [github pages](https://pages.github.com/themes/), but for this blog we will be using the [minima](https://github.com/jekyll/minima) but on the last release still in development (v3), not the stable one (2.5), due the last release integrates the dark theme.

In order to use the dark theme, we have to enable the "remote theme" in the config.yml

```
remote_theme: jekyll/minima
plugins:
  - jekyll-remote-theme
minima:
  skin: dark # or auto if you want it to switch with your system settings.
```

If we want the minima theme with latest version in local, we could eventually install it (Not needed to deploy in github pages)

```
git clone https://github.com/jekyll/minima.git
cd minima
gem build
gem install --local minima-3.0.0.dev.gem
```

## Custom Style
If a custom CSS is needed, we could create the file

`\_sass\minima\custom-styles.scss`

with the desired style.

For example, if a custom button is needed to change the blog page, we could add the following on the css file,

```
.button {
    border: none;
    padding: 12px 28px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
}

.buttonblue {
    background-color: #79B8FF;
    color: black;
}
```

And using this style in the markdown page,

```
<button class="button buttonblue" onclick="window.location.href='https....html';">Next</button>
```

***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
