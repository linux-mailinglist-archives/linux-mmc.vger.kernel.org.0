Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029E1100C8
	for <lists+linux-mmc@lfdr.de>; Tue, 30 Apr 2019 22:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfD3U2e (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 30 Apr 2019 16:28:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43757 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3U2e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Apr 2019 16:28:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id a12so22472896wrq.10
        for <linux-mmc@vger.kernel.org>; Tue, 30 Apr 2019 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6BX6/WUNOoSiFLmAFQqGnF6/PRbz+EhjmT+iJ67/mUY=;
        b=tYmHnixEDXEt2SAOXn0QJ2Vj/azLQQUXwgXGIkZmZNXwc0/pdtI/uQl2yIUyLmh94g
         1NR4t88UJ5eNIR58MgE8GCkz4Nkf4+F8vSMhl5t/ePlHWPTxEmeDrz5LzTyPnFPOGwbI
         fn3HB0SlYx2JPz/gcR+/lxXMP6XAE67l5/sPgAmDCS5Cx/JT8rDzInP37Ay7rfK8o8nL
         8vCnP3C/8PAY3BhSAMyyLCXVDFXH5YQUII8ULcpyo89oUOiEHag/FhFBUIOVqkK42Job
         Mq+DeFKSFStprkJWPSDyOXehOIeanq9S5z8s7sCM6T4Ik286C0qudiAxbMEBRwU61Cg4
         AHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6BX6/WUNOoSiFLmAFQqGnF6/PRbz+EhjmT+iJ67/mUY=;
        b=gIZIBB3WkrxCBSfnWt+vHY/AwPUCnws2XK9SneHHhumfE+4JkiHKeweu72EAWtjhMm
         YTnK2mcwZ8KBmq398itwo3gqbDgV7mJ8BYp1VP4W0aWHrquKVWPw+YG3MEC+LWBOgCmL
         2bkdy6cMi3T91WNrwyx6pvUUeMrklBi99z84H6OjzR7R8vouhAsfdq6KYX+hVFJUPu/3
         B6ylEZ9q8G9hBgRP7OgqLp5IxCOeDv95lxuulVIyPpHCT5kslSImd5APJmhcQXgzPUVQ
         qeUUZjVEgrXbh0e+V5fe3xIWsNjkxzFlnckz5AEEsz2PuvckQbPD41dvTxresljEP8P7
         SGxA==
X-Gm-Message-State: APjAAAVdZIc15bL8Xx7d5/zxrYgy57EWXxC2LEtBEzHKgWO1E6h50i7z
        neUJjSKDolgy6v4nJuOqqD7urg==
X-Google-Smtp-Source: APXvYqz2S/xfszL0oWRG5GwXUJqfH6R2Vhb5FSkaVEgWr59FELVaoP/P20oTjWxy+aom60m3VdZUeg==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr7146640wrx.193.1556656112020;
        Tue, 30 Apr 2019 13:28:32 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id o5sm3076191wmc.16.2019.04.30.13.28.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Apr 2019 13:28:31 -0700 (PDT)
Message-ID: <0bd1e9c25ab11112c9f2913c2cb3483e8802099d.camel@baylibre.com>
Subject: Re: [PATCH v2 4/7] mmc: meson-gx: disable HS400
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 30 Apr 2019 22:28:27 +0200
In-Reply-To: <CAFBinCBpujeLJHr0x9DxqLtRiLt0WLkkOoKcJuh3baWeg_bFeA@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
         <20190423090235.17244-5-jbrunet@baylibre.com>
         <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
         <17c5978419c8778eb1f2c2a6e2aee66e864ac53d.camel@baylibre.com>
         <CAFBinCCus5T7LvH7aTMYmc5gKoFkZFR-MCMGK8bSV_eAsu9Svw@mail.gmail.com>
         <936229765eac2bcdacf9a53925bb17c38ea18e3a.camel@baylibre.com>
         <CAFBinCBpujeLJHr0x9DxqLtRiLt0WLkkOoKcJuh3baWeg_bFeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 2019-04-30 at 22:02 +0200, Martin Blumenstingl wrote:
> > Thanks for effort but all this just maintain the blur around HS400 on amlogic.
> > 
> > Let me rephrase it:
> > Tuning (phase or resampling) is meant to compensate the clock round trip in UHS
> > and HS200 modes. In HS400, this should be taken care of by the data strobe.
> > But we have not been to enable this reliably enable this on amlogic chipset ...
> I wasn't aware of this: so far I assumed that we're not setting the
> phase correctly, end of the story.
> thank you again for taking your time to explain this!

No worries. There is the MMC in general, I think I understand it a bit now but 
I might still be mistaken about some stuff. Then there is the HW we have and the
related black magic.

I doubt this is the last update in this driver ...

> 
> > ... and I believe we are back to the original commit message.
> no need to update the description just to explain how HS400 works in
> general, so feel free to use my:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


