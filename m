Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0912C6D22E2
	for <lists+linux-mmc@lfdr.de>; Fri, 31 Mar 2023 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjCaOqZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 31 Mar 2023 10:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjCaOqY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2023 10:46:24 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050141F7A6;
        Fri, 31 Mar 2023 07:46:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id B1DF560515;
        Fri, 31 Mar 2023 16:46:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680273974; bh=5RG06B8y+BKSa4kCy+JhHfX47z8+Ymz8u2e3pd1Ehq0=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Uw8AnfQ9CxSwUIloxw/9HJBrwjNAFip/PuJKplLaPnBfqqB/LPjLfZccXlUPmLhFi
         tFd6Upv/du85VOIwLe1o7Ql1IRvfmu/yIGro3dt8uRSASyZR6RcxYPFT9N+ZsqhnKK
         GPDna38h3VEhRk1z4LuelXpx3QGNS2Nq+fmt3xyqfuLOpBVauIHDznHB8YYUlhJltV
         NX43hkzw+r9YPtH9a+5XlOlOU65LNE8hgqmFUY1hFNIHdhbzk+8ZBUNniFK3btIR61
         O+esXi592czFN85xYDzDjIkSbI5nvpaTChn/9nFz4gIuDTYMvGU/RNg30Ns6EuqLyb
         X4AOBgDIojlag==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vk6XISqswbHR; Fri, 31 Mar 2023 16:46:11 +0200 (CEST)
Received: from [10.0.1.38] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id C2FAE60514;
        Fri, 31 Mar 2023 16:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680273971; bh=5RG06B8y+BKSa4kCy+JhHfX47z8+Ymz8u2e3pd1Ehq0=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=neQj24sfGinUcHYG2mMRQozMrhMUKITCtHujLk0XCRM0VlJazh0lUv9BjvkdKSdNe
         cbx93sM6amtH722zSxFicEJoy1xetGP48hlaxLLEeAh1r1PQAK6iICTrHTWTWTX0Rf
         H0YO8cKI2IVOFV6kpwfZwZDLQEDUSHG+vld0o5fqhZi4H+9CjecARHKzOi7tVt07XB
         Wu0Yj2Kbm+lbFuXI9iTZOuCV0v9zjy4SBO+8B8YtXHMF6mgvroiCERkPGx/RI1RmdY
         oxKDHq4X50y9EtFglUvRzIjl02pzCr/hXrZgdDfASA5tbv2Vych4v1libHoJepUE1p
         /kh9KbOLfz5QA==
Message-ID: <df560535-2a8e-de21-d45d-805159d70954@alu.unizg.hr>
Date:   Fri, 31 Mar 2023 16:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: BUG FIX: [PATCH RFC v2] memstick_check() memleak in kernel 6.1.0+
 introduced pre 4.17
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hannes Reinecke <hare@suse.de>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>, linux-mmc@vger.kernel.org
References: <7d873dd3-9bab-175b-8158-c458b61a7122@alu.unizg.hr>
 <f74219a7-1607-deb4-a6ae-7b73e2467ac7@alu.unizg.hr>
Content-Language: en-US, hr
In-Reply-To: <f74219a7-1607-deb4-a6ae-7b73e2467ac7@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29.3.2023. 19:25, Mirsad Goran Todorovac wrote:
> On 23.12.2022. 14:20, Mirsad Goran Todorovac wrote:
>> Hi all,
>>
>> When building a RPM 6.1.0-rc3 for AlmaLinux 8.6, I have enabled CONFIG_DEBUG_KMEMLEAK=y
>> and the result showed an unreferenced object in kworker process:
>>
>> cat /sys/kernel/debug/kmemleak
>> unreferenced object 0xffff888105028d80 (size 16):
>>    comm "kworker/u12:5", pid 359, jiffies 4294902898 (age 1620.144s)
>>    hex dump (first 16 bytes):
>>      6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00  memstick0.......
>>    backtrace:
>>      [<ffffffffb6bb5542>] slab_post_alloc_hook+0xb2/0x340
>>      [<ffffffffb6bbbf5f>] __kmem_cache_alloc_node+0x1bf/0x2c0
>>      [<ffffffffb6af8175>] __kmalloc_node_track_caller+0x55/0x160
>>      [<ffffffffb6ae34a6>] kstrdup+0x36/0x60
>>      [<ffffffffb6ae3508>] kstrdup_const+0x28/0x30
>>      [<ffffffffb70d0757>] kvasprintf_const+0x97/0xd0
>>      [<ffffffffb7c9cdf4>] kobject_set_name_vargs+0x34/0xc0
>>      [<ffffffffb750289b>] dev_set_name+0x9b/0xd0
>>      [<ffffffffc12d9201>] memstick_check+0x181/0x639 [memstick]
>>      [<ffffffffb676e1d6>] process_one_work+0x4e6/0x7e0
>>      [<ffffffffb676e556>] worker_thread+0x76/0x770
>>      [<ffffffffb677b468>] kthread+0x168/0x1a0
>>      [<ffffffffb6604c99>] ret_from_fork+0x29/0x50
>>
>> mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log
>> git bisect start
>> # bad: [f0c4d9fc9cc9462659728d168387191387e903cc] Linux 6.1-rc4
>> git bisect bad f0c4d9fc9cc9462659728d168387191387e903cc
>> # bad: [fbd56ddcecab5a3623a89c8e941fdbcc55b41045] Linux 6.0.1
>> git bisect bad fbd56ddcecab5a3623a89c8e941fdbcc55b41045
>> # bad: [7e18e42e4b280c85b76967a9106a13ca61c16179] Linux 6.0-rc4
>> git bisect bad 7e18e42e4b280c85b76967a9106a13ca61c16179
>> # bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
>> git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>> # bad: [84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d] Linux 4.19
>> git bisect bad 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d
>> # bad: [94710cac0ef4ee177a63b5227664b38c95bbf703] Linux 4.18
>> git bisect bad 94710cac0ef4ee177a63b5227664b38c95bbf703
>> # bad: [29dcea88779c856c7dc92040a0c01233263101d4] Linux 4.17
>> git bisect bad 29dcea88779c856c7dc92040a0c01233263101d4
>>
>> Greg asked me if I would help bisect the bug, since I failed to reproduce it on pre 4.17 kernels, because they wouldn't boot 
>> (black screen) on the Lenovo ALmaLinux 8.7 (CentOS fork) desktop box that only reproduced that bug:
>>
>>      product: 10TX000VCR (LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
>>      vendor: LENOVO
>>      version: V530S-07ICB
>>
>> I would welcome any advice.
>>
>> Please find attached the lshw output and the build config from the last kernel version that also exhibits this bug, so the 
>> conclusion is that it is not fixed since the report on November 29th 2022:
>>
>> https://lore.kernel.org/regressions/0d9c3f6c-3948-d5d1-bcc1-baf31141beaa@alu.unizg.hr/T/#t
>>
>> With the hint of Tvrtko, I was able to extract the correct list of maintainers this time.
>>
>> The bug occurs in one kernel memory leak, and it is unobvious whether a skilled attacker could use an abusive program to trigger 
>> the leak of enough 16 byte slabs (and overhead) to exhaust kernel memory and cause denial-of-service (crash of the system).
>>
>> I apologise for the first unsuccessful attempt.
> 
> static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
> 
> calls dev_set_name(&card->dev, "%s", dev_name(&host->dev)); that
> calls err = kobject_set_name_vargs(&dev->kobj, fmt, vargs); that
> executes:
> 
>      if (strchr(s, '/')) {
>          char *t;
> 
>          t = kstrdup(s, GFP_KERNEL);
>          kfree_const(s);
>          if (!t)
>              return -ENOMEM;
>          strreplace(t, '/', '!');
>          s = t;
>      }
>      kfree_const(kobj->name);
>      kobj->name = s;
> 
> so, this kobj->name was never freed in the "goto err_out" case in line 404.
> 
> 380 static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
> 381 {
> 382         struct memstick_dev *card = kzalloc(sizeof(struct memstick_dev),
> 383                                             GFP_KERNEL);
> 384         struct memstick_dev *old_card = host->card;
> 385         struct ms_id_register id_reg;
> 386
> 387         if (card) {
> 388                 card->host = host;
> 389                 dev_set_name(&card->dev, "%s", dev_name(&host->dev));
> 390                 card->dev.parent = &host->dev;
> 391                 card->dev.bus = &memstick_bus_type;
> 392                 card->dev.release = memstick_free_card;
> 393                 card->check = memstick_dummy_check;
> 394
> 395                 card->reg_addr.r_offset = offsetof(struct ms_register, id);
> 396                 card->reg_addr.r_length = sizeof(id_reg);
> 397                 card->reg_addr.w_offset = offsetof(struct ms_register, id);
> 398                 card->reg_addr.w_length = sizeof(id_reg);
> 399
> 400                 init_completion(&card->mrq_complete);
> 401
> 402                 host->card = card;
> 403                 if (memstick_set_rw_addr(card))
> 404                         goto err_out;
> 405
> 406                 card->next_request = h_memstick_read_dev_id;
> 407                 memstick_new_req(host);
> 408                 wait_for_completion(&card->mrq_complete);
> 409
> 410                 if (card->current_mrq.error)
> 411                         goto err_out;
> 412         }
> 413         host->card = old_card;
> 414         return card;
> 415 err_out:
> 416         host->card = old_card;
> 421         kfree(card);
> 422         return NULL;
> 423 }
> 
> This little patch fixes it, also at the release() method.
> 
> However, release() had not yet been tested, and I am not certain that in that case
> kobj->name would not be kfree_const()-ed automatically.
> 
> Maybe it ought to be separated in two independent patches?
> 
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index bf7667845459..403ab06e3ffa 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -191,6 +191,10 @@ static void memstick_free_card(struct device *dev)
>   {
>          struct memstick_dev *card = container_of(dev, struct memstick_dev,
>                                                   dev);
> +       if ((card->dev).kobj.name) {
> +               kfree_const((card->dev).kobj.name);
> +               (card->dev).kobj.name = NULL;
> +       }
>          kfree(card);
>   }
> 
> @@ -410,6 +414,10 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>          return card;
>   err_out:
>          host->card = old_card;
> +       if ((card->dev).kobj.name) {
> +               kfree_const((card->dev).kobj.name);
> +               (card->dev).kobj.name = NULL;
> +       }
>          kfree(card);
>          return NULL;
>   }
> 
> This morning I did not feel like we'd fix two memory leaks today.
> 
> This one was a nag for three months :-)
> 
> Of course, this requires peer review. The fact that it fixed the /sys/kernel/debug/kmemleak
> output doesn't mean that it wouldn't break something, does it?
> 
> It is clearly the good wind of the Providence.

This is the second version of the patch, without the paranoid parentheses.

I am still in the process of convincing Thunderbird not to convert tabs to
spaces, so please use --ignore-whitespace when testing this patch. :-(

---
  drivers/memstick/core/memstick.c | 8 ++++++++
  1 file changed, 8 insertions(+)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index bf7667845459..390287c23f27 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -191,6 +191,10 @@ static void memstick_free_card(struct device *dev)
  {
         struct memstick_dev *card = container_of(dev, struct memstick_dev,
                                                  dev);
+       if (card->dev.kobj.name) {
+               kfree_const(card->dev.kobj.name);
+               card->dev.kobj.name = NULL;
+       }
         kfree(card);
  }

@@ -410,6 +414,10 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
         return card;
  err_out:
         host->card = old_card;
+       if (card->dev.kobj.name) {
+               kfree_const(card->dev.kobj.name);
+               card->dev.kobj.name = NULL;
+       }
         kfree(card);
         return NULL;
  }


-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

