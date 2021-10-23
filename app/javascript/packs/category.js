function appendCategories() {
    let parentCategory = document.getElementById('parent_category').value;
    if (parentCategory != "---") {
        fetch("get_category_children", requestOptions)
        .then(response => response.json())
        .then(data => console.log(data))
    }

    const requestOptions = {
        method: 'GET',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({parent_name: parentCategory})
    }
}

const getParentCategory = document.querySelector("#parent_category");
getParentCategory.addEventListener('change', appendCategories); 
