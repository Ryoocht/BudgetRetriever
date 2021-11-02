const appendOption = category => {
    let html = `<li id="${category.id}">${category.name}</li>`
    return html;
}

const appendChildrenBox = (insertHTML, status) => {
    let childSelectHtml = "";
    childSelectHtml = `
        <ul>
            <li class="subcategory_title">Subcategory</li>
            <ul class="subcategory_name">
                ${insertHTML}
            </ul>
        </ul>`;
    grandChildSelectHtml = `
        <ul>
            <li class="further_subcategory_title">Further Subcategory</li>
            <ul class="further_subcategory_name">
                ${insertHTML}
            </ul>
        </ul>`;
    const div = document.createElement("div");
    if (status === "parent") {
        div.classList.add("subcategory_list");
        div.innerHTML = childSelectHtml;
        document.querySelector(".all_categories").appendChild(div);
    } else {
        div.classList.add("further_subcategory_list");
        div.innerHTML = grandChildSelectHtml;
        document.querySelector(".all_categories").appendChild(div);
    }
}

const insertChildHTML = (data, status) => {
    let insertHTML = "";
    data.forEach(child => {
        insertHTML += appendOption(child);
    });
    appendChildrenBox(insertHTML, status);
}

//fetch category data to BillsController routes and get sorted category data from its route
const appendModel = (childRoute, e) => {
    const selectedValue = e.target.id
    console.log(e.target.parentElement.className)
    if (selectedValue != "---") {
        fetch(`categories/${childRoute}?category_id=${selectedValue}`)
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
            const subcat = document.querySelector(".subcategory_list");
            const fursubcat = document.querySelector(".further_subcategory_list");
            //Parent Category List
            if (e.target.parentElement.className !== "subcategory_name") {
                if (subcat || fursubcat) {
                    subcat.remove();
                    fursubcat.remove();
                }
                insertChildHTML(data, "parent");
                const subcategory_list = document.querySelector(".subcategory_name");
                handleSubcategory(subcategory_list);
            //Child Category List
            } else {
                if (fursubcat) {
                    fursubcat.remove();
                }
                insertChildHTML(data, "child");
            }
        })
        .catch((error) => {console.error('Error:', error)});
    }
}

const appendCategories = e => {
    appendModel("get_category_children", e)
}

const appendSubcategories = e => {
    appendModel("get_category_grandchildren", e)
}

const getCategory = document.querySelector(".category_name");
getCategory.addEventListener('click', appendCategories);

const handleSubcategory = subcategory_list => {
    subcategory_list.addEventListener('click', appendSubcategories);
}
