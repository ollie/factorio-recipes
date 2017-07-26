class Recipe
  class << self
    def calculate(name, amount, level: 1, raws: {})
      recipe = all.fetch(name)

      if recipe[:raw]
        raws[name] ||= 0
        raws[name]  += amount
      end

      ingredients =
        # Include (or not) Iron plate in Steel?
        if false && recipe[:raw]
          []
        else
          recipe.fetch(:ingredients).reject { |ingredient| all.fetch(ingredient.fetch(:name))[:ore] }.map do |ingredient|
            ingredient_name = ingredient.fetch(:name)
            # Some recipes produce 2 items.
            ingredient_amount = amount.to_f / recipe.fetch(:amount, 1) * ingredient.fetch(:amount, 1)
            calculate(ingredient_name, ingredient_amount, level: level + 1, raws: raws)
          end
        end

      {
        amount: amount,
        name: name,
        ingredients: ingredients
      }.tap do |hash|
        hash[:raws] = raws if level == 1
      end
    end

    def all
      @all ||= begin
        {}.tap do |hash|
          MultiJson.load(File.read('data/recipes.json'), symbolize_keys: true).each do |recipe|
            name = recipe.fetch(:name)
            raise "Recipe #{name.inspect} already exists" if hash[name]
            hash[name] = recipe
          end
        end.deep_freeze!
      end
    end
  end
end
