const appendOption = category => {
    let html = `<li id="${category.id}">${category.name}</li>`;
    return html;
}

const appendChildrenBox = (insertHTML, status) => {
    let childSelectHtml = "";
    childSelectHtml = `
        <ul>
            <li class="category_title">Subcategory</li>
            <ul class="subcategory_name">
                ${insertHTML}
            </ul>
        </ul>`;
    grandChildSelectHtml = `
        <ul>
            <li class="category_title">Further Subcategory</li>
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
    const selectedValue = e.target.id;
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
    appendModel("get_category_children", e);
}

const appendSubcategories = e => {
    appendModel("get_category_grandchildren", e);
}

const getCategory = document.querySelector(".category_name");
getCategory.addEventListener('click', appendCategories);

const handleSubcategory = subcategory_list => {
    subcategory_list.addEventListener('click', appendSubcategories);
}

//each button action
const category_list = document.querySelector(".all_categories");
const category_field = document.querySelector(".category_input_field");
const category_table = document.querySelector(".category_table");
const edit_table = document.querySelector(".edit_table");
const list_button = document.querySelector("#all_list_button");
const add_button = document.querySelector("#add_button");
const edit_button = document.querySelector("#edit_button");
const delete_button = document.querySelector("#delete_button");
const main_table = document.querySelector(".main_category_table");
const sub_table = document.querySelector(".subcategory_table");

//category list element visibility
const listEventHandler = () => {
    if (category_list.className.includes("visibilityOn")) {
        category_list.classList.remove("visibilityOn");
        category_field.classList.add("visibilityOn");
        category_table.classList.add("visibilityOn");
    } else {
        category_field.classList.add("visibilityOn");
    }
}

//add element visibility
const addEventHandler = () => {
    if (category_field.className.includes("visibilityOn")) {
        category_field.classList.remove("visibilityOn");
        category_table.classList.add("visibilityOn");
        edit_table.classList.add("visibilityOn");
    } else {
        category_field.classList.add("visibilityOn");
        category_list.classList.remove("visibilityOn");
    }
}

//edit element visibility
const editEventHandler = () => {
    if (category_table.className.includes("visibilityOn")) {
        category_table.classList.remove("visibilityOn");
        category_field.classList.add("visibilityOn");
        category_list.classList.add("visibilityOn");
        edit_table.classList.add("visibilityOn");
        category_table.classList.remove("delete_clicked");
    } else {
        category_table.classList.add("visibilityOn");
        category_list.classList.remove("visibilityOn");
        category_table.classList.remove("delete_clicked");
    }
}

const updateEventHandler = () => {
    if (edit_table.className.includes("visibilityOn")) {
        edit_table.classList.remove("visibilityOn");
        category_field.classList.add("visibilityOn");
        category_list.classList.add("visibilityOn");
    } else {
        edit_table.classList.add("visibilityOn");
        category_table.classList.remove("visibilityOn");
    }
}

list_button.addEventListener('click', listEventHandler);
add_button.addEventListener('click', addEventHandler);
edit_button.addEventListener('click', editEventHandler);
delete_button.addEventListener('click', () => {
    editEventHandler();
    if (!category_table.className.includes("visibilityOn")) {
        category_table.className += " delete_clicked";
    } else {
        category_table.classList.remove("delete_clicked");
    }
});
main_table.addEventListener('click', updateEventHandler);
sub_table.addEventListener('click', updateEventHandler);

//target clicked category table
const updateCategoryForm = category => {
    let html = ` 
        <div class="selected_element">
            <p class="input-title">Selected Category</p>
            <input type="hidden" name="category[id]" value=${category.id}>
            <input type="text" name="category[name]" id=${category.id} value=${category.name} class="category-update-box">
            <input type="submit" value="UPDATE">
        </div>`;
    return html;
}

const getParentCategory = category => {
    let html = `
        <div class="parent_element">
            <p>${category.name}</p>
            <i class="fas fa-chevron-right"></i>
        </div`;
    return html;
}

const insertData = data => {
    hasData = document.querySelector(".insertHTML");
    if (hasData) {
        hasData.remove();
    }
    const div = document.createElement("div");
    const edit_table = document.querySelector(".edit_table");
    div.className = "insertHTML";
    
    const appendSelect = (select, element) => {
        element.innerHTML = updateCategoryForm(select);
        edit_table.appendChild(element);
    }
    
    const appendParents = (select, element) => {
        element.innerHTML += getParentCategory(select);
    }

    if (data.grand_parent) {
        appendSelect(data.select, div);
        appendParents(data.parent, div);
        appendParents(data.grand_parent, div);
        
    } else if (data.parent) {
        appendSelect(data.select, div);
        appendParents(data.parent, div);
    } else {
        appendSelect(data.select, div);
    }
}

const getSelectedTable = e => {
    const selectedValue = e.target.id;
    if (selectedValue !== "undefined") {
        fetch(`categories/get_selected_category?category_id=${selectedValue}`)
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
            insertData(data);
        })
        .catch((error) => {console.error('Error:', error)});
    }
}

const deleteSetectedTable = e => {
    const selectedValue = e.target.id;
    if (selectedValue !== "undefined") {
        fetch(`categories/delete_selected_category?category_id=${selectedValue}`)
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
        })
        .catch((error) => {console.error('Error:', error)});
    }
}

const targetTable = document.querySelector(".main_category_table");
const targetSubTable = document.querySelector(".subcategory_table");
targetTable.addEventListener('click', e => {
    if (category_table.className.includes("delete_clicked")) {
        deleteSetectedTable(e);
    } else {
        getSelectedTable(e);
    }
});
targetSubTable.addEventListener('click', e => {
    if (category_table.className.includes("delete_clicked")) {
        deleteSetectedTable(e);
    } else {
        getSelectedTable(e);
    }
});