Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4D8634DED
	for <lists+linux-mmc@lfdr.de>; Wed, 23 Nov 2022 03:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiKWCe1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 22 Nov 2022 21:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiKWCe1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2022 21:34:27 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA4A725FA
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2022 18:34:26 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NH4v7185TzRpRr;
        Wed, 23 Nov 2022 10:33:55 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 10:34:24 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 10:34:23 +0800
Subject: Re: [PATCH v4 0/2] mmc: sdio: fixes some leaks
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <yangyingliang@huawei.com>
References: <20221110025530.4106568-1-yangyingliang@huawei.com>
 <cd06c6cc-fd5a-1fe4-9570-4266f34918cd@huawei.com>
 <CAPDyKFrYk9Gr3Fa5mJ2KPebCWXxGFJxZtP47EmXge3CRMtEYQg@mail.gmail.com>
 <CAPDyKFqb_Yx26yZ2Ak=q1YTEQBm6rS4r8FXqa5nV5VUf-hMh-g@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <0d8a9a6f-1764-3939-f405-e8ecd338a7ea@huawei.com>
Date:   Wed, 23 Nov 2022 10:34:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqb_Yx26yZ2Ak=q1YTEQBm6rS4r8FXqa5nV5VUf-hMh-g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 2022/11/23 0:29, Ulf Hansson wrote:
> On Fri, 18 Nov 2022 at 09:10, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On Fri, 18 Nov 2022 at 08:54, Yang Yingliang <yangyingliang@huawei.com> wrote:
>>> Hi,
>>>
>>> On 2022/11/10 10:55, Yang Yingliang wrote:
>>>> This patchset fix a refcount leak and two memory leaks about
>>>> SDIO function.
>>>>
>>>> v3 -> v4:
>>>>     Drop patch1, keep calling put_device() to free memory,
>>>>     set 'func->card' to NULL to avoid redundant put.
>>>>
>>>> v2 -> v3:
>>>>     Change to call of_node_put() in remove() function to
>>>>     fix node refcount leak.
>>>>
>>>> v1 -> v2:
>>>>     Fix compile error in patch #2.
>>>>
>>>> Yang Yingliang (2):
>>>>     mmc: sdio: fix of node refcount leak in sdio_add_func()
>>>>     mmc: sdio: fix possible memory leak in some error path
>>>>
>>>>    drivers/mmc/core/sdio.c     | 1 +
>>>>    drivers/mmc/core/sdio_bus.c | 6 +++---
>>>>    drivers/mmc/core/sdio_cis.c | 3 ++-
>>>>    3 files changed, 6 insertions(+), 4 deletions(-)
>>> Is this look good to you, or any suggestions?
>> I need some more time to review them, so I will get back to this early
>> next week.
> I have re-started to look into these patches, so I will provide you
> with some comments very soon.
>
> Although, may I ask how you have tested these changes? Or are the
> changes done from a pure code inspection point of view?
Compiled test only.

Thanks,
Yang
>
> Kind regards
> Uffe
> .
