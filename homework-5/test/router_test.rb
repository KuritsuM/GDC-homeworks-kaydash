require 'rspec/core'
require_relative '../task-2/router'

RSpec.describe "post controller" do
  it "should add new posts" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('First post', 'Second post', 'Third post')

    controller = PostsController.new
    0.upto(2) { controller.create }

    expected_result = ['First post', 'Second post', 'Third post']

    expect(controller.index).to eq(expected_result)
  end

  it "should delete second post" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('First post', 'Second post', 'Third post', '1')

    controller = PostsController.new
    0.upto(2) { controller.create }
    controller.destroy

    expected_result = ['First post', 'Third post']

    expect(controller.index).to eq(expected_result)
  end

  it "should update second post" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('First post', 'Second post', 'Third post', '1', 'update')

    controller = PostsController.new
    0.upto(2) { controller.create }
    controller.update

    expected_result = ['First post', 'update', 'Third post']

    expect(controller.index).to eq(expected_result)
  end

  it "should retern post with index 0" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('First post', 'Second post', 'Third post', '0')

    controller = PostsController.new
    0.upto(2) { controller.create }

    expected_result = 'First post'

    expect(controller.show).to eq(expected_result)
  end
end
