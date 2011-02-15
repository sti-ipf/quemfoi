<h1>Frequência dos Participantes</h1>

<table>
  <tr>
    <th>Participante</th>
    <th>Frequência</th>
    <th>Aprovado?</th>
  </tr>

<% @partcipants.each do |info| %>
  <tr>
    <td><%=h info[:participant][:name] %></td>
    <td><%=h (info[:participant][:time]/@participant[:total_time])*100 %></td>
    <td><%= (info[:participant][:time]/@participant[:total_time])*100 > 75 ? "Sim"|"Não"  %></td>
  </tr>
<% end %>
</table>

<br />

<%= link_to 'Nova formação', new_course_path %>
