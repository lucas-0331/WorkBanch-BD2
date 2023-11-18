---
layout: page
title: Membros
description: Uma lista de todos os membros relacionados ao curso.
---

<h1 align="center"> <span style='font-weight: bold;'> Membros </span> </h1>

## Coordenadores

{% assign instructors = site.staffers | where: 'role', 'Coordenador' %}
{% for staffer in instructors %}
{{ staffer }}
{% endfor %}

{% assign teaching_assistants = site.staffers | where: 'role', 'Professor' %}
{% assign num_teaching_assistants = teaching_assistants | size %}
{% if num_teaching_assistants != 0 %}

## Professores

{% for staffer in teaching_assistants %}
{{ staffer }}
{% endfor %}
{% endif %}
