// Get references to the tbody element and button for loading additional results
var $tbody = document.querySelector("tbody");
var $dateInput = document.querySelector("#datetime");
var $searchBtn = document.querySelector("#search");

// Add an event listener to the searchButton, call handleSearchButtonClick when clicked
$searchBtn.addEventListener("click", handleSearchButtonClick);

// Set filteredAddresses to addressData initially
var filteredDatetime = dataSet;

// renderTable renders the filteredAddresses to the tbody
function renderTable() {
  $tbody.innerHTML = "";
  for (var i = 0; i < filteredDatetime.length; i++) {
    // Get get the current address object and its fields
    var datetime = filteredDatetime[i];
    var fields = Object.keys(datetime);
    // Create a new row in the tbody, set the index to be i + startingIndex
    var $row = $tbody.insertRow(i);
    for (var j = 0; j < fields.length; j++) {
      // For every field in the address object, create a new cell at set its inner text to be the current value at the current address's field
      var field = fields[j];
      var $cell = $row.insertCell(j);
      $cell.innerText = datetime[field];
    }
  }
}

function handleSearchButtonClick() {
  // Format the user's search by removing leading and trailing whitespace, lowercase the string
  var filterDatetime = $dateInput.value.trim();

  // Set filteredAddresses to an array of all addresses who's "state" matches the filter
  filteredDatetime = dataSet.filter(function(datetime) {
    var datadatetime = datetime.datetime;

    // If true, add the address to the filteredAddresses, otherwise don't add it to filteredAddresses
    return datadatetime === filterDatetime;
  });
  renderTable();
}

// Render the table for the first time on page load
renderTable();
