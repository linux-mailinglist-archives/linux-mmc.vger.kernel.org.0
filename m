Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B132D109A
	for <lists+linux-mmc@lfdr.de>; Mon,  7 Dec 2020 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgLGMeW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-mmc@lfdr.de>); Mon, 7 Dec 2020 07:34:22 -0500
Received: from aposti.net ([89.234.176.197]:53508 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgLGMeW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 7 Dec 2020 07:34:22 -0500
Date:   Mon, 07 Dec 2020 12:33:18 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] mmc: mediatek: mark PM functions as __maybe_unused
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        yong mao <yong.mao@mediatek.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ARM/Mediatek SoC support <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-Id: <IVYYKQ.T5GFS8Z1QTP2@crapouillou.net>
In-Reply-To: <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com>
References: <20201203222922.1067522-1-arnd@kernel.org>
        <CAPDyKFqtFYqc8i_fVzOUnuZGJjtwjVLqE-vebtOKuYJ-4PrDBg@mail.gmail.com>
        <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Arnd,

Le ven. 4 d�c. 2020 � 15:14, Arnd Bergmann <arnd@kernel.org> a �crit 
:
> On Fri, Dec 4, 2020 at 11:02 AM Ulf Hansson <ulf.hansson@linaro.org> 
> wrote:
>>  On Thu, 3 Dec 2020 at 23:29, Arnd Bergmann <arnd@kernel.org> wrote:
> 
>>  > -#ifdef CONFIG_PM
>>  >  static void msdc_save_reg(struct msdc_host *host)
>> 
>>  Shouldn't msdc_save|restore_reg() be turned into "__maybe_unused" 
>> as well?
> 
> There is no need since the compiler can figure that out already when 
> there
> is a reference to the function from dead code.
> 
>>  >
>>  > -static int msdc_resume(struct device *dev)
>>  > +static int __maybe_unused msdc_resume(struct device *dev)
>>  >  {
>>  >         return pm_runtime_force_resume(dev);
>>  >  }
>>  > -#endif
>>  >
>>  >  static const struct dev_pm_ops msdc_dev_pm_ops = {
>> 
>>  You may also change this to a __maybe_unused, as long as you also
>>  assign the .pm pointer in the mt_msdc_driver with
>>  pm_ptr(&msdc_dev_pm_ops).
>> 
>>  Ideally the compiler should drop these functions/datas entirely 
>> then.
> 
> I don't see a lot of other instances of that yet, and it's fairly new.
> Maybe we should fix it before it gets propagated further.
> 
> I would suggest we redefine pm_ptr like
> 
> #define pm_ptr(_ptr) (IS_ENABLED(CONFIG_PM) ? (_ptr) : NULL)

By the way, as I'm ending up doing the same in a different context, I 
think it would be useful to have a IF_ENABLED() macro defined like this:

#define IF_ENABLED(_cfg, _ptr) (IS_ENABLED(_cfg) ? (_ptr) : NULL)

Then the pm_ptr(_ptr) macro could be defined like this:

#define pm_ptr(_ptr) IF_ENABLED(CONFIG_PM, _ptr)

Cheers,
-Paul

> and remove the __maybe_unused annotations on those that we
> already have. This also has the effect of dropping the unused
> data from the object, but without having to an an #ifdef or
> __maybe_unused.
> 
> Adding Paul and Rafael to Cc for clarification on this.
> 
>        Arnd


