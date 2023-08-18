describe('Visit Home Page', () => {

  it('should visit the home page', () => {
    cy.visit('/');
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("Navigate to a product detail page", () => {
    cy.get(".products article").first().find("a").click();
    
  });

 
});
