Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7531104F8
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Dec 2019 20:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLCTVq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Dec 2019 14:21:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36047 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfLCTVq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Dec 2019 14:21:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so4427313oic.3;
        Tue, 03 Dec 2019 11:21:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cdQMfe7gqO6u8R+MtPZjybUjPu5whVykoij0oQ0zinw=;
        b=H6yO9VjBYxqdfa4I+IF9DDnAIKGZJ1/jxGwzB2sRSB/SjxqVskWVwARlv7a7wG7wDt
         yfbcMmjIAJTF5p6qjj5OU1siEDeiyhqYA/FQHHwNayn1EcG6RmFAJjqaI6nrVffJhwGM
         aLEsppTN5qbUteAMnnxnV4ZHlZiEoI8ndz6xRBAdoBE3DnhZq6M4Va4F5gN2gL6CEugV
         /QoNeNBIW6g+LEMveqP3A8bh8aOccL0zN26HfSVBrtmVtNq+TE0RuVs33gb4KVpDPsZ6
         Wg5ZzJe4VsIOqhOD1bUmhwVwz6Tz4I61HzWO9jyJtPmHUACCxDTp4Z35DdI/koA45zz1
         mzug==
X-Gm-Message-State: APjAAAUJfx6o8hElgoaBRqQpAXxTC+wQjXZkPrPbDq9Nxly3c/jB7igP
        0B7TMtRYQ9tpjOAdOO1X6Q==
X-Google-Smtp-Source: APXvYqzczdsECXTX4WiTyARZIQ+hRWtQiR09aXTBjDZGGX5IVsolMehakbG7gD0IhC6Ot6FJmXx3WA==
X-Received: by 2002:aca:ed81:: with SMTP id l123mr5124773oih.129.1575400905290;
        Tue, 03 Dec 2019 11:21:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p1sm463894otl.1.2019.12.03.11.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 11:21:44 -0800 (PST)
Date:   Tue, 3 Dec 2019 13:21:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, festevam@gmail.com,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com
Subject: Re: [PATCH 08/14] doc: dt: fsl-imx-esdhc: add
 strobe-dll-delay-target binding
Message-ID: <20191203192143.GA24098@bogus>
References: <1573816606-26779-1-git-send-email-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573816606-26779-1-git-send-email-haibo.chen@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Nov 2019 19:16:45 +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Add fsl,strobe-dll-delay-target binding.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
