class CombineItemsInCart < ActiveRecord::Migration
  def up
# ������ ���������� ������� ��� ������ � ���� �� ������ � ������� ����� �������
    Cart.all.each do |cart|
# ������� ���������� ������� ������ � �������
      sums = cart.line_items.group(:good_id).sum(:quantity)
      sums.each do |good_id, quantity|
        if quantity > 1
# �������� ��������� �������
          cart.line_items.where(good_id: good_id).delete_all
# ������ ����� �������
          item = cart.line_items.build(good_id: good_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
# ��������� ������� � quantity>1 �� ��������� �������
    LineItem.where("quantity>1").each do |line_item|
# add individual items
      line_item.quantity.times do
        LineItem.create cart_id: line_item.cart_id,
                        good_id: line_item.good_id, quantity: 1
      end
# �������� �������� ������
      line_item.destroy
    end
  end

end
