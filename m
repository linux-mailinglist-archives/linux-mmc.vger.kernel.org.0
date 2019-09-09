Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B250AE10F
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Sep 2019 00:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfIIWcq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 18:32:46 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46342 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbfIIWcq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2019 18:32:46 -0400
Received: by mail-ua1-f65.google.com with SMTP id k12so4874161uan.13
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkJ02h0fBo9r8kWdWdUhcb/UyWYGr8bXb4xIws2KF3U=;
        b=j3UA/A270TR5kmBN5gzV6Zua0L7zQb4G0yy8X8v7x3XMlDIps2dObWryhvUTyTpAq8
         Z0WDUJEM8OmEG72VL39C6rYuaQtXckBYNR1ZpZA9oxVvLziKNIEserbuwuo4JKo/7GJZ
         lETYNHvfUbACUjN+xn6tGJOsOvQqESw8cW6T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkJ02h0fBo9r8kWdWdUhcb/UyWYGr8bXb4xIws2KF3U=;
        b=QwRqao6O7DaugPuVaUWtWOWUOdIMZpQwIdcEXujvAYIP96deXErDEeqEAIMDLnljhr
         +s9Y8T0zNM7+n3R2J6VDugSlQjyRHx7J+aL53pC0saTJQuibxVWsOhilq69mgPdKROQ1
         YfPEWtWRC37gFzZacUBxNzaWcGbpvUQE7M/K9CqzCC2yrlybz/Y9IUSAHnRMTKwp79HO
         Mhliw2Ofge3ic/ZoITRcq8hxhVzRnn5eDO/pMN49ljABY5Im+eF7GloYJwY0IramEjny
         KK8EFl4Bg7Q8O4kuxKsYean7G5MkLoJONAXI8hH/MQ6UPhD8ln2xdaFygsATloAkM8dz
         +T5g==
X-Gm-Message-State: APjAAAUXo5W1WKvDy9VNKESpBKhsi8JRBB6xUGB9J5h3ar4J/twnTDYt
        7xLGnygtE6PP+ZzLHuC2V2qNcz2HCSw=
X-Google-Smtp-Source: APXvYqxdAV1t1Zwgss/SUA3cvCBZe5Od1vxRJmGXHD/sgAnVZtBKMimT8x6GCtXKx2zUmhw4AOvQFQ==
X-Received: by 2002:ab0:20a6:: with SMTP id y6mr7829342ual.119.1568068365096;
        Mon, 09 Sep 2019 15:32:45 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id j27sm4250223vsj.11.2019.09.09.15.32.44
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:32:44 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id 107so4904610uau.5
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:32:44 -0700 (PDT)
X-Received: by 2002:a9f:3f8a:: with SMTP id k10mr12637508uaj.121.1568068363612;
 Mon, 09 Sep 2019 15:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-2-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-2-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:32:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XLsbvhPA4ap3nZCLk1fZiPHALvOv0=uh+jGZ-VY=xYEA@mail.gmail.com>
Message-ID: <CAD=FV=XLsbvhPA4ap3nZCLk1fZiPHALvOv0=uh+jGZ-VY=xYEA@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] mmc: core: Add helper function to indicate if
 SDIO IRQs is enabled
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> To avoid each host driver supporting SDIO IRQs, from keeping track
> internally about if SDIO IRQs has been claimed, let's introduce a common
> helper function, sdio_irq_claimed().
>
> The function returns true if SDIO IRQs are claimed, via using the
> information about the number of claimed irqs. This is safe, even without
> any locks, as long as the helper function is called only from
> runtime/system suspend callbacks of the host driver.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Renamed function to sdio_irq_claimed().
>
> ---
>  include/linux/mmc/host.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
