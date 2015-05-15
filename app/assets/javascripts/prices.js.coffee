class Prices

  this.prices_data = (table_data, data) ->
    # Append the data fetched from the server to the table.
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
  $('#price-button').click (event) ->
    $('#prices-data').empty() #empty the table before populating it again.
    event.preventDefault()
    state_value = $('#state').val()
    if !state_value.length || state_value.length == 2 #check for invalid state name
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

# These are use to display message to the server that data is being loaded
  loader_msg = $('#loading-prices')
  loader_msg.hide()

  $(document).on 'ajaxStart', ->
    loader_msg.show()
  $(document).on 'ajaxStop', ->
    loader_msg.hide()