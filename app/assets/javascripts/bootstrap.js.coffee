#= require twitter/bootstrap/bootstrap-dropdown
#= require twitter/bootstrap/bootstrap-tooltip
#= require twitter/bootstrap/bootstrap-popover
#= require twitter/bootstrap/bootstrap-tab

jQuery ->
  $(".dropdown-toggle").dropdown()
#  $(".alert-message").alert()
#  $(".tabs").button()
#  $(".carousel").carousel()
#  $(".collapse").collapse()
#  $(".modal").modal()
  $("a[rel=popover]").popover()
#  $(".navbar").scrollspy()
#  $(".tab").tab "show"
  $(".tooltip").tooltip()
#  $(".typeahead").typeahead()
  $("a[rel=tooltip]").tooltip()
