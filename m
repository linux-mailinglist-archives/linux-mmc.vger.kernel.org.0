Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 752571304CD
	for <lists+linux-mmc@lfdr.de>; Sat,  4 Jan 2020 22:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgADVz1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 4 Jan 2020 16:55:27 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37817 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgADVz1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Jan 2020 16:55:27 -0500
Received: by mail-il1-f194.google.com with SMTP id t8so39421076iln.4
        for <linux-mmc@vger.kernel.org>; Sat, 04 Jan 2020 13:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/EnumApSDmaO9XbzKzz36+u0K1L2iTuLSdvygNUnhs=;
        b=dlm9ozuKAVTusED21S2AcSbMw9MTvUb7YGLKdnXc8KfLreDx+G7wAGFnrlGp2CNzgA
         rFToEV6WMyL+Fq0yIa7Wx/7XsMhhAEHG324aSz5Zt8Ytpaox9pFnPym2VwFcwy75yXxJ
         To62fc/qwxoyhApJ1z58Wf8w8xWJz06llyCarXI26HEmk3AhpRvgbQI97EAzDridJGJB
         BactXEThxhVFOE+tPkVhAwZ0OxZra4kOp5W3AGlJS2ypjvmwkuuwysjUdDMiMqJR9n06
         p2c5Da7RmCzUnTOUknIY1NOz9Zu2x7w+8WwArUJ+RJ6HijO+ihbtsfnpoJ5B2dILPsTs
         fc/g==
X-Gm-Message-State: APjAAAUsvyr8/RugvXu73LDdrupEp0JvpUlKs9G5knUO/0zg35Y7Wf8r
        c43j3Zf1XS5i3k4pVjK8qIvtlIA=
X-Google-Smtp-Source: APXvYqyeCCbitdS4SjLSQtBhzZ22S8Irhcu0RL6SqDelLACsJRHfPf1BkhXcarDvtl6m0sl0uR64RQ==
X-Received: by 2002:a92:c686:: with SMTP id o6mr55048337ilg.212.1578174926726;
        Sat, 04 Jan 2020 13:55:26 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c23sm11429198iod.62.2020.01.04.13.55.25
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:55:26 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:55:24 -0700
Date:   Sat, 4 Jan 2020 14:55:24 -0700
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: remove identical phrase in
 disable-wp text
Message-ID: <20200104215524.GA28188@bogus>
References: <20191219145843.3823-1-jbx6244@gmail.com>
 <20191228093059.2817-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228093059.2817-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 28 Dec 2019 10:30:58 +0100, Johan Jonker wrote:
> There are two identical phrases in the disable-wp text,
> so remove one of them.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks.

Rob
