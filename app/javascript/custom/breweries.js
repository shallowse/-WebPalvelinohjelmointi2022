const BREWERIES = {};

const handleResponse = breweries => {
  BREWERIES.list = breweries;
  BREWERIES.show();
};

const createTableRow = brewery => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");

  const name = tr.appendChild(document.createElement("td"));
  name.innerHTML = brewery.name;

  const year = tr.appendChild(document.createElement("td"));
  year.innerHTML = brewery.year;

  const beerCount = tr.appendChild(document.createElement("td"));
  beerCount.innerHTML = brewery.beers.count;

  const active = tr.appendChild(document.createElement("td"));
  active.innerHTML = brewery.active ? 'Active' : 'Inactive';

  return tr;
};

BREWERIES.show = () => {
  document.querySelectorAll('.tablerow').forEach(el => el.remove());
  const table = document.getElementById('brewerytable');

  BREWERIES.list.forEach(brewery => {
    const tr = createTableRow(brewery);
    table.appendChild(tr);
  });
};

BREWERIES.sortBy = how => {
  switch (how) {
    case 'name':
      BREWERIES.list.sort((a, b) => a.name.toUpperCase().localeCompare(b.name.toUpperCase()));
      break;
    case 'year':
      BREWERIES.list.sort((a, b) => a.year.toUpperCase().localeCompare(b.year.toUpperCase()));
      break;
    case 'beer_count':
      BREWERIES.list.sort((a, b) => a.beers.count - b.beers.count);
      break;
    default:
      BREWERIES.list.sort((a, b) => a.name.toUpperCase().localeCompare(b.name.toUpperCase()));
      break;
  }
};

const breweries = () => {
  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortBy('name');
    BREWERIES.show();
  });

  document.getElementById("year").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortBy('year');
    BREWERIES.show();
  });

  document.getElementById("beer_count").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortBy('beer_count');
    BREWERIES.show();
  });

  fetch('breweries.json')
    .then(response => response.json())
    .then(handleResponse);
};

export { breweries }