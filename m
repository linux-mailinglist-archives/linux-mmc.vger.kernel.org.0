Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45805AE111
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Sep 2019 00:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfIIWc4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 18:32:56 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44946 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbfIIWc4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2019 18:32:56 -0400
Received: by mail-ua1-f66.google.com with SMTP id z8so4886486uaq.11
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2/wdjSFx2+V/ddpY88+7IJ+97cajsbLNJq+vIVE05k=;
        b=GsssujDG2Jb1LEpkEswcOYwgHaexAs9/2blhp1bINcplff13C20hpT93h15JDcjMXC
         beaKFpQeCBOT0ojrnOjOUBbdawlhBx8SzkD31yx8g4SLZq/p82s1oLTzcx2JZkgC79YH
         d03hUr59Fiw2VWMX1DlmE9yUaxK3BgKf+aC7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2/wdjSFx2+V/ddpY88+7IJ+97cajsbLNJq+vIVE05k=;
        b=qAMKCK6HBv0Ae4tG3r3KQl+NulZQ8K8n4zwHooFI7VFN/sY//OAt8UVzbMwjwzmEad
         0v87OLGsz1deaooG0FGZAOccKWTTpYb9937OrkpWREatllX2qLDraXr/Wf1jDIww3qQY
         nxgwG5uzCUJLEjgd16OmOXo4Fe/cvK7ZcqYV5L6gm1fK2uEExprujAh39Vpi5jEUTpHS
         DdqUUovJ7ocC4yzs6BPm4Pmt0ZHvAySbg2Bpu5TBbbGts6XTAeH60xcaH49DzeLOBI8k
         mCSpDO+fAOgeT/TKqMScOc7hyKI1YsTmnZf0dbTAq92kSYvvxZRnWkb3Fsi+x+O9Wwb5
         oBEg==
X-Gm-Message-State: APjAAAWwYtj+buCO7wdEXcOZDpEhDl6exMUsVHiK+98OgF96tzWxLQFR
        +p7kUyD8uTyrYRl/3MuEz96Yu8uNCUE=
X-Google-Smtp-Source: APXvYqxmOUJrxru3gOwdtdX0QwNOD8nNfVjvr1R5XwjfltPLhwmTcPYBefbWa+oYMWWhFo1h/cBIJw==
X-Received: by 2002:ab0:503:: with SMTP id 3mr6509543uax.96.1568068375373;
        Mon, 09 Sep 2019 15:32:55 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id g128sm5236290vsc.17.2019.09.09.15.32.54
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:32:54 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id i17so4893540ual.7
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:32:54 -0700 (PDT)
X-Received: by 2002:a9f:24c4:: with SMTP id 62mr6002335uar.104.1568068374367;
 Mon, 09 Sep 2019 15:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-3-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-3-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:32:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V3gkAW6xLdi_yPkKzwZCMAgnmHKYi-jpXTzqS1+EU5fA@mail.gmail.com>
Message-ID: <CAD=FV=V3gkAW6xLdi_yPkKzwZCMAgnmHKYi-jpXTzqS1+EU5fA@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
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
> In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> called during system suspend/resume, via pm_runtime_force_suspend|resume().
> This means during system suspend/resume, the register context of the dw_mmc
> device most likely loses its register context, even in cases when SDIO IRQs
> have been enabled.
>
> To re-enable the SDIO IRQs during system resume, the dw_mmc driver
> currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> the SDIO card, but this isn't the recommended solution. Instead, it's
> better to deal with this locally in the dw_mmc driver, so let's do that.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
