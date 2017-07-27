class Recipe
  class << self
    def tree(name, amount, level: 1)
      recipe = all.fetch(name)

      ingredients =
        # Include (or not) Iron plate in Steel?
        if false && recipe[:raw]
          []
        else
          recipe.fetch(:ingredients).reject { |ingredient| all.fetch(ingredient.fetch(:name))[:ore] }.map do |ingredient|
            ingredient_name = ingredient.fetch(:name)
            # Some recipes produce 2 items.
            ingredient_amount = amount.to_f / recipe.fetch(:amount, 1) * ingredient.fetch(:amount, 1)
            tree(ingredient_name, ingredient_amount, level: level + 1)
          end
        end

      {
        amount: amount,
        name: name,
        ingredients: ingredients
      }
    end

    def raws(tree, raws: {})
      name   = tree.fetch(:name)
      recipe = all.fetch(name)

      if recipe[:raw]
        raws[name] ||= 0
        raws[name]  += tree.fetch(:amount)
      end

      tree.fetch(:ingredients).each do |ingredient_tree|
        self.raws(ingredient_tree, raws: raws)
      end

      raws
    end

    def totals(tree, totals: {})
      name = tree.fetch(:name)

      totals[name] ||= 0
      totals[name]  += tree.fetch(:amount)

      tree.fetch(:ingredients).each do |ingredient_tree|
        self.totals(ingredient_tree, totals: totals)
      end

      totals
    end

    def machines(totals, machine: 'Assembling machine 2')
      {}.tap do |machines|
        totals.reject { |name, _| all.fetch(name)[:raw] }.each do |name, amount|
          recipe         = all.fetch(name)
          machine_recipe = all.fetch(machine)
          machines[name] = (amount / (recipe.fetch(:amount_per_second) * machine_recipe.fetch(:crafting_speed))).ceil
        end
      end
    end

    def smelters(totals)
      {}.tap do |smelters|
        totals.select { |name, _| all.fetch(name)[:raw] }.each do |name, amount|
          recipe         = all.fetch(name)
          smelters[name] = (amount * recipe.fetch(:smelting)).ceil
        end
      end
    end

    def all
      @all ||= begin
        {}.tap do |hash|
          MultiJson.load(File.read('data/recipes.json'), symbolize_keys: true).each do |recipe|
            name = recipe.fetch(:name)
            raise "Recipe #{name.inspect} already exists" if hash[name]
            recipe[:amount_per_second] = recipe.fetch(:amount, 1).to_f / recipe.fetch(:time)
            hash[name] = recipe
          end
        end.deep_freeze!
      end
    end
  end
end
