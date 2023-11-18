---
layout: page
title: Notícias
description: Página voltada para divulgação de notícias e avisos relacionados ao curso.
nav_order: 1
---

<h1 align="center"> <span style='font-weight: bold;'>Notícias</span> </h1>

{% assign announcements = site.announcements | reverse %}
{% for announcement in announcements %}
{{ announcement }}
{% endfor %}
