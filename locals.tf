locals {
  hdr_prefix = "${var.heimdallr.system.id}-${var.env.id}"
  hdr_tags = {
    Env    = var.env.name
    System = var.heimdallr.system.name
    Stack  = local.hdr_prefix
  }

  trs_prefix = "${var.trista.system.id}-${var.env.id}"
  trs_tags = {
    Env    = var.env.name
    System = var.trista.system.name
    Stack  = local.trs_prefix
  }
}
