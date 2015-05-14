class Prices

  this.prices_data = (table_data, data) ->
    table_data.empty()
    $.each data, (state, price) ->
      row =
        "<tr>
          <td colspan='3'>#{state}</td>
          <td>#{price}</td>
        </tr>"
      table_data.append(row)
      table_data.show()

$ = jQuery
$ ->
  $('#price-button').click ->
    event.preventDefault()
    state_value = $('#state').val()
    if !state_value.length || state_value.length == 2
      query_data = if !!state_value then {state: state_value} else {}
      $.ajax
        url: "/prices"
        type: 'GET'
        data: query_data
        success: (data) ->
          Prices.prices_data($('#prices-data'), data)
        error: ->
          alert "No prices found!"
    else
      alert("State Name should be only 2 characters. E.g.: 'NY' or 'NJ'. Try Again!")