const appendOption = category => {
    let html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
}

const appendChildrenBox = (insertHTML, status) => {
    let childSelectHtml = "";
    childSelectHtml = `
        <p class="input-title">Subategory</p>
        <select name="bill[subcategoryid]" class="dropdown-style subcategory_selecter" id="bill_subcategory_id"><br>
            <option value="---" data-category="---">---</option>
            ${insertHTML}
        </select>`;
    grandChildSelectHtml = `
        <p class="input-title">Further Subcategory</p>
        <select name="bill[further_subcategoryid]" class="dropdown-style further_subcategory_selecter" id="bill_further_subcategory_id"><br>
            <option value="---" data-category="---">---</option>
            ${insertHTML}
        </select>`;
    const div = document.createElement("div");
    if (status === "parent") {
        div.classList.add("subcategory_wrapper");
        div.innerHTML = childSelectHtml;
        document.querySelector(".category-field").appendChild(div);
    } else {
        div.classList.add("further_subcategory_wrapper");
        div.innerHTML = grandChildSelectHtml;
        document.querySelector(".category-field").appendChild(div);
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
    const selectedValue = document.querySelector(`#${e.target.id}`).value;
    if (selectedValue != "---") {
        fetch(`${childRoute}?category_id=${selectedValue}`)
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
            const subcat = document.querySelector(".subcategory_wrapper")
            const fursubcat = document.querySelector(".further_subcategory_wrapper")
            //Parent Category Selector
            if (e.target.id !== "bill_subcategory_id") {
                if (subcat || fursubcat) {
                    subcat.remove();
                    fursubcat.remove();
                }
                insertChildHTML(data, "parent");
                const subcategory_selector = document.querySelector("#bill_subcategory_id");
                handleSubcategory(subcategory_selector);
            //Child Category Selector
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

const getCategory = document.querySelector("#bill_category_id");
getCategory.addEventListener('change', appendCategories);

const appendSubcategories = e => {
    appendModel("get_category_grandchildren", e)
}

const handleSubcategory = getCategory => {
    getCategory.addEventListener('change', appendSubcategories);
}