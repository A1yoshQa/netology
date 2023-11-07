resource "local_file" "hosts" { 
  content = templatefile("./hosts.tftpl", {
    vms = yandex_compute_instance.vms
  })
  filename = "../playbook/inventory/hosts.yml"
}

resource "null_resource" "hosts_provision" {
#Ждем создания инстанса
  depends_on = [yandex_compute_instance.vms]

#Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command = "cat ~/.ssh/id_rsa | ssh-add -"
  }

#Костыль!!! Даем ВМ время на первый запуск. Лучше выполнить это через wait_for port 22 на стороне ansible
 provisioner "local-exec" {
    command = "sleep 30"
  }

#Запуск ansible-playbook
  provisioner "local-exec" {                  
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ../playbook/inventory/hosts.yml ../playbook/site.yml"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
    triggers = {  
      always_run         = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
      playbook_src_hash  = file("../playbook/test.yml") # при изменении содержимого playbook файла
    }

}
