json.select do
    json.id  @selected_category.id
    json.name  @selected_category.name
end

if @parent
    json.parent do
        json.id  @parent.id
        json.name  @parent.name
    end
end

if @grand_parent
    json.grand_parent do
        json.id  @grand_parent.id
        json.name  @grand_parent.name
    end
end