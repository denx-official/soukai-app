# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'change', '#project_id', ->
# form の action をもとに vote_id を取得。
# 新規登録の場合は votes が設定される。
work = $(this).parents('form').attr('action').split('/');

$.ajax(
  type: 'GET'
  url: '/votes/project_options_select'
  data: {
    vote_id: work[work.length - 1],
    project_id: $(this).val()
  }
).done (data) ->
  $('#project_options_select').html(data)