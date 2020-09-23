Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBC3275860
	for <lists+linux-mmc@lfdr.de>; Wed, 23 Sep 2020 15:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgIWNEX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 23 Sep 2020 09:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWNEX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2020 09:04:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105C1C0613CE;
        Wed, 23 Sep 2020 06:04:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u3so3134578pjr.3;
        Wed, 23 Sep 2020 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:cc:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=7E+MYfBlV9Majnt8yvu7cDkaRWAr8/bGpIJBzwX7WYw=;
        b=mKMuc6O8gjCmz2Kc66iuSpeA0HohDxNJR9EJta0vlbQBvxj4zqYabTrWXkafBfHCEo
         YToSCYgVByZXT+NOfChF2RiZhHoFjCOmFDSXmSIwYdCLCaQSSdwde/1w+56X1HvwfD2/
         KLeCUAzL33U1ABgJQRhC4/AWNCTYXq6kE8dD1pl5ib6nN4+lRFtqu2c2Mx8brBHaSqu4
         affvSU/DTNks8dO+r8JYZW0lEUldSY/usuVUqiwrbRYASbt/1F4zp7YQM+9Ov/exjtML
         KdHqyTrjQqerce/1/vLIYMtmghj+tzW8pIbiNFOSDkXSRZ4k4kHFGFQM747vQS4OHJDW
         0Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=7E+MYfBlV9Majnt8yvu7cDkaRWAr8/bGpIJBzwX7WYw=;
        b=o0QHuv6oUMnHarD9R66xUpInxVgjM1jk/tdrShtYQ5n4ijGj4GtrPRCN28sNUqWSCS
         H3WdP0h1eRxC/H7cpPWyimbYbSQ999Z8c5vMi9QeB1wxc7N3xhMzWOkHZ3+NHSkZ30Az
         Uwfc7IYrXrtHtfrK7QmfKnowXD33n54DdIN0Rg/l7o4eK8o2PJB3/FJ7wYuYo8oSGEi4
         UFoPsJSeJ9DgWGDqKCAZH0pHD5htCSPvALCzVmMseSy7Rt8p6uXpmKGNCCxL8vw4hHCq
         Xa+1AA4WHMaNx1xlLv+H8CrQHSy4NSx+h/pDCx4m0nLliaXuz9GBpHrS4SYWrI0WyrnG
         vJ8Q==
X-Gm-Message-State: AOAM533UaOEBxqqFD7W/xNIEOS7Fa7uogyAmqXZEPKuoH/QgsCZ6M25o
        c1WznOz9Yxa3nmvkt+V1K3c=
X-Google-Smtp-Source: ABdhPJyXE9GR7fNWyB9zmWzWOpjev0FYltYlM1N0FAkvxD4rC4b7N9BuI14xkSaFqjbhiGIaCzGahA==
X-Received: by 2002:a17:90b:f83:: with SMTP id ft3mr8090904pjb.234.1600866262366;
        Wed, 23 Sep 2020 06:04:22 -0700 (PDT)
Received: from ?IPv6:2402:b801:2840:8200:e4f7:baaa:ff2a:bf24? ([2402:b801:2840:8200:e4f7:baaa:ff2a:bf24])
        by smtp.gmail.com with ESMTPSA id e2sm17777231pgl.38.2020.09.23.06.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 06:04:21 -0700 (PDT)
To:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
From:   Brad Harper <bjharper@gmail.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mmc: host: meson-gx-mmc: fix possible deadlock condition for
 preempt_rt
Message-ID: <24a844c3-c2e0-c735-ccb7-83736218b548@gmail.com>
Date:   Wed, 23 Sep 2020 23:04:15 +1000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Force threaded interrupts for meson_mmc_irq to prevent possible deadlock 
condition
during mmc operations when using preempt_rt with 5.9.0-rc3-rt3 patches 
on arm64.

Using meson-gx-mmc with an emmc device on Hardkernel Odroid N2+ 
configured with
preempt_rt resulted in the soc becoming unresponsive.  With lock 
checking enabled
the below inconsistent lock state was observed during boot.

After some discussions with tglx in IRC #linux-rt the attached patch was 
suggested
to remove IRQF_ONESHOT from request_threaded_irq.
This has been tested and confirmed by me to resolve both the 
unresponsive soc and
the inconsistent lock state warning when using 5.9.0-rc3-rt3 on arm64 
Odroid N2+.

Further review and testing is required to ensure there are no adverse 
impacts or
concerns and that is the correct method to resolve the problem.  I will 
continue
to test on various amlogic devices with both standard mainline low 
latency kernel
and preempt_rt kernel with -rt patches.

[ 7.858446] ================================
[ 7.858448] WARNING: inconsistent lock state
[ 7.858450] 5.9.0-rc3-rt3+ #33 Not tainted
[ 7.858453] --------------------------------
[ 7.858456] inconsistent {IN-HARDIRQ-R} -> {HARDIRQ-ON-W} usage.
[ 7.858459] swapper/0/1 [HC0[0]:SC0[0]:HE1:SE1] takes:
[ 7.858465] ffff80001219f4d8 (&trig->leddev_list_lock){+?.+}-{0:0}, at: 
led_trigger_set+0x104/0x270
[ 7.858482] {IN-HARDIRQ-R} state was registered at:
[ 7.858484] lock_acquire+0xec/0x468
[ 7.858491] rt_read_lock+0xb0/0x108
[ 7.858497] led_trigger_event+0x34/0x88
[ 7.858501] mmc_request_done+0x3f0/0x450
[ 7.858505] meson_mmc_irq+0x284/0x378
[ 7.858511] __handle_irq_event_percpu+0xcc/0x4a8
[ 7.858515] handle_irq_event_percpu+0x60/0xb0
[ 7.858519] handle_irq_event+0x50/0x108
[ 7.858522] handle_fasteoi_irq+0xd0/0x180
[ 7.858527] generic_handle_irq+0x38/0x50
[ 7.858530] __handle_domain_irq+0x6c/0xc8
[ 7.858533] gic_handle_irq+0x5c/0xb8
[ 7.858537] el1_irq+0xbc/0x180
[ 7.858540] arch_cpu_idle+0x28/0x38
[ 7.858544] default_idle_call+0x90/0x3f0
[ 7.858547] do_idle+0x250/0x268
[ 7.858551] cpu_startup_entry+0x2c/0x78
[ 7.858554] rest_init+0x1b0/0x284
[ 7.858559] arch_call_rest_init+0x18/0x24
[ 7.858565] start_kernel+0x550/0x588
[ 7.858569] irq event stamp: 1925495
[ 7.858571] hardirqs last enabled at (1925495): [<ffff8000111e3ba4>] 
_raw_spin_unlock_irqrestore+0xa4/0xb0
[ 7.858576] hardirqs last disabled at (1925494): [<ffff8000111e3c58>] 
_raw_spin_lock_irqsave+0xa8/0xb8
[ 7.858580] softirqs last enabled at (1857856): [<ffff80001024705c>] 
bdi_register_va+0x114/0x368
[ 7.858586] softirqs last disabled at (1857849): [<ffff80001024705c>] 
bdi_register_va+0x114/0x368
[ 7.858590]
other info that might help us debug this:
[ 7.858592] Possible unsafe locking scenario:
[ 7.858594] CPU0
[ 7.858595] ----
[ 7.858597] lock(&trig->leddev_list_lock);
[ 7.858600] <Interrupt>
[ 7.858602] lock(&trig->leddev_list_lock);
[ 7.858604]
*** DEADLOCK ***
[ 7.858606] 3 locks held by swapper/0/1:
[ 7.858609] #0: ffff80001219eb30 (leds_list_lock){++++}-{0:0}, at: 
led_trigger_register+0xf4/0x1c0
[ 7.858619] #1: ffff0000b0696a70 (&led_cdev->trigger_lock){+.+.}-{0:0}, 
at: led_trigger_register+0x134/0x1c0
[ 7.858629] #2: ffff800011fb83d0 (rcu_read_lock){....}-{1:2}, at: 
rt_write_lock+0x8/0x108
[ 7.858637]
stack backtrace:
[ 7.858640] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc3-rt3+ #33
[ 7.858643] Hardware name: Hardkernel ODROID-N2Plus (DT)
[ 7.858646] Call trace:
[ 7.858647] dump_backtrace+0x0/0x1e8
[ 7.858650] show_stack+0x20/0x30
[ 7.858653] dump_stack+0xf0/0x164
[ 7.858659] print_usage_bug+0x2b4/0x2c0
[ 7.858662] mark_lock+0x2e8/0x360
[ 7.858665] __lock_acquire+0x238/0x1858
[ 7.858669] lock_acquire+0xec/0x468
[ 7.858672] rt_write_lock+0xb0/0x108
[ 7.858675] led_trigger_set+0x104/0x270
[ 7.858678] led_trigger_register+0x180/0x1c0
[ 7.858681] heartbeat_trig_init+0x28/0x5c
[ 7.858686] do_one_initcall+0x90/0x4bc
[ 7.858690] kernel_init_freeable+0x2cc/0x338
[ 7.858694] kernel_init+0x1c/0x11c
[ 7.858697] ret_from_fork+0x10/0x34

Signed-off-by: Brad Harper <bjharper@gmail.com>
---
  drivers/mmc/host/meson-gx-mmc.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c 
b/drivers/mmc/host/meson-gx-mmc.c
index 08a3b1c05..130ac134d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1139,7 +1139,7 @@ static int meson_mmc_probe(struct platform_device 
*pdev)
                host->regs + SD_EMMC_IRQ_EN);

         ret = request_threaded_irq(host->irq, meson_mmc_irq,
-                                  meson_mmc_irq_thread, IRQF_ONESHOT,
+                                  meson_mmc_irq_thread, 0,
                                    dev_name(&pdev->dev), host);
         if (ret)
                 goto err_init_clk;
--
2.20.1

