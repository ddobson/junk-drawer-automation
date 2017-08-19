After do
  if Capybara.current_driver == :selenium
    page.execute_script <<-JAVASCRIPT
      localStorage.clear();
    JAVASCRIPT
  end
end
