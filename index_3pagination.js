// Get references to the tbody element and button for loading additional results
var $tbody = document.querySelector("tbody");
var $dateInput = document.querySelector("#datetime");
var $cityInput= document.querySelector("#city");
var $stateInput= document.querySelector ("#state");
var $countryInput=document.querySelector('#country');
var $shapeInput= document.querySelector ('#shape');
var $searchBtn = document.querySelector("#search");
var $loadMoreBtn = document.querySelector("#load-btn");

// Pagination
var startingIndex= 0;
var resultsPerPage = 100;
var endingIndex = startingIndex + resultsPerPage;
var dataSubset = dataSet.slice(startingIndex, endingIndex);

// Add an event listener to the searchButton and loadMoreBtn
$searchBtn.addEventListener("click", handleSearchButtonClick);
$loadMoreBtn.addEventListener("click", handleButtonClick);


// renderTable renders to the tbody
function renderTableSection() {
  //var endingIndex = startingIndex + resultsPerPage;

  //var dataSubset = dataSet.slice(startingIndex, endingIndex);
  for (var i = 0; i < dataSubset.length; i++) {

  var data = dataSubset[i];
  var fields = Object.keys(data);

    var $row = $tbody.insertRow(i+startingIndex);
    for (var j = 0; j < fields.length; j++) {

      var field = fields[j];
      var $cell = $row.insertCell(j);
      $cell.innerText = data[field];
    }
  }
}

function handleSearchButtonClick() {
  // Format the user's search by removing leading and trailing whitespace, lowercase the string
  var filterDatetime = $dateInput.value.trim();
  var filterState = $stateInput.value.trim().toLowerCase();
  var filterCity = $cityInput.value.trim().toLowerCase();
  var filterShape = $shapeInput.value.trim().toLowerCase();
  var filterCountry = $countryInput.value.trim().toLowerCase();

  // Set filteredData to an array that matches the filter
  //filteredData = dataSubset
  //filteredDatetime = dataSubset.filter(function(data) {
  filteredData= dataSubset.filter(function(data) {
    var datadatetime = data.datetime;
    var datastate = data.state.substring(0, filterState.length).toLowerCase();
    var datacity = data.city.substring(0, filterCity.length).toLowerCase();
    var datacountry = data.country.substring(0, filterCountry.length).toLowerCase();
    var datashape = data.shape.substring(0, filterShape.length).toLowerCase();

    
    if (datadatetime === filterDatetime && datastate=== filterState && datacity=== filterCity && datacountry=== filterCountry && datashape === filterShape) {
      return true;
  }
    return false;
   });
}

function handleButtonClick() {
  
  startingIndex += resultsPerPage;
  renderTableSection();
  // Check to see if there are any more results to render
  if (startingIndex + resultsPerPage >= dataSet.length) {
    $loadMoreBtn.classList.add("disabled");
    $loadMoreBtn.innerText = "All Addresses Loaded";
    $loadMoreBtn.removeEventListener("click", handleButtonClick);
  }
}
renderTableSection();


