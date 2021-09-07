function genMenu() {
  var menu = [
    {
      id: "index",
      class: "nav",
      href: "./index.html",
      target: "_self",
      text: "Home",
    },
    {
      id: "bio",
      class: "nav",
      href: "./bio.html",
      target: "_self",
      text: "Bio",
    },
    {
      id: "pub",
      class: "nav",
      href: "./publications.html",
      target: "_self",
      text: "Publications",
    },
    {
      id: "projects",
      class: "nav",
      href: "./projects.html",
      target: "_self",
      text: "Projects",
    },
    {
      id: "software",
      class: "nav",
      href: "./software.html",
      target: "_self",
      text: "Software",
    },
    {
      id: "extra",
      class: "nav",
      href: "./extra.html",
      target: "_self",
      text: "Extra",
    },
    {
      id: "data",
      class: "nav",
      href: "./data.html",
      target: "_self",
      text: "Data",
    },
    {
      id: "teaching",
      class: "nav",
      href: "./teaching.html",
      target: "_self",
      text: "Teaching",
    },
  ];

  var nav = '<ul> <li class="listHeader">Menu</li>';

  for (ilist = 0; ilist < menu.length; ilist++) {
    nav =
      nav +
      ' <li><a id="' +
      menu[ilist].id +
      '" class="' +
      menu[ilist].class +
      '" href="' +
      menu[ilist].href +
      '" target="' +
      menu[ilist].target +
      '">' +
      menu[ilist].text +
      " </li>";
  }

  nav = nav + " </ul>";

  document.getElementById("menu").innerHTML = nav;
}
