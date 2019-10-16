Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FA8D9312
	for <lists+linux-mmc@lfdr.de>; Wed, 16 Oct 2019 15:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393729AbfJPNxW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Oct 2019 09:53:22 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:39954 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393717AbfJPNxW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Oct 2019 09:53:22 -0400
Received: by mail-lf1-f44.google.com with SMTP id f23so2061818lfk.7
        for <linux-mmc@vger.kernel.org>; Wed, 16 Oct 2019 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sne+YXo0/GnUShJ6y/Z9u1jsbG8849ICm+y2RnjKJjg=;
        b=qYzSHQvh//K8Y5Kx+JUJ5u/gqvyaJi3A62OJCB6dTg2FRcLmqr1+CjfjEAUJ3XXMR+
         uHNpcWpYZm03YVY4Hw0+xqhK185IfGjNL0XdwrKGpAm9ovAjLsDN1Z90wGfs1cqZKX5X
         24YHyYBXWsYlqjngvApqz4n5xHOAl0dy+MqbHqrkzb5B80Veh1BVPKxNyb9wbqWPkDG2
         CNTFufWJQzeC6aQC7HT20YIv85OXy0mgJ41GQyV+ecdqxX9YtS4ZTNOeHQzU3gW0jybd
         c6YuMyy6rsquE1vx2cwetaq7kkxOMViWl3rQUrnoX06HoeiooskkYofO6F5/IkIjQG31
         +MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sne+YXo0/GnUShJ6y/Z9u1jsbG8849ICm+y2RnjKJjg=;
        b=HIrhEfB9btRrXOjmLvBb7nzCRFXAbXqbCVeoJIcA1PfAODOuvt5Zw0grnWXaHaZwUH
         1SG6mEWAPp/T9CZhyAJrCGZXeljdGzlGK2+d6z8bxB0zDJa7OI44j5jfAKx7QrbAlIII
         OxO/v9cPLdL3aaEDdo4JwcpdpFW+VEAj7IL46FhSPXiUQ8WC0oTYUhnfj2Yd8KGn0I7O
         j3dvZIbryeJYRIAO0Rt9K1SdenmcrPS3+PP8GcMrv94NnrIoRmyLSvl58sZecXtXHZex
         GJ9CIaGatQaOCennly3NH6M/j7sMlmReQ3u73NFItHOqwBLqnJ5Ath7g647Ky533K+Co
         1e4A==
X-Gm-Message-State: APjAAAWk5lB9yRtp3JQOjOJyMqkhpSwMubTF33vx5fA4+FOmE3w6KVV9
        5hkWiM6HOvJV2byrx/fYXG8DlegeK6kBMK6dGWo=
X-Google-Smtp-Source: APXvYqzJVx0Yc/1nHjXxD7axwTwhfHvNQoJHYh1mWvcmYYgYjm2WbMDaCM3ZKrYi15apuRXnHWQjTQfZnytSkD0Uy0I=
X-Received: by 2002:ac2:4a68:: with SMTP id q8mr2236875lfp.20.1571233999920;
 Wed, 16 Oct 2019 06:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5ACYH_vuf4FevsPNkdxt8Y0irFeDNDcFns1bhsxB=M68w@mail.gmail.com>
 <20191015144054.kd2cgn2xhctr6x3w@pengutronix.de>
In-Reply-To: <20191015144054.kd2cgn2xhctr6x3w@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 16 Oct 2019 10:53:17 -0300
Message-ID: <CAOMZO5CDKTdDCV6LDEeSzQScCmLc14oRJgDq0h4eSX5vmqTbpg@mail.gmail.com>
Subject: Re: mmc failure on mx28 running 5.3.2
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Marek Vasut <marex@denx.de>, Stefan Wahren <info@lategoodbye.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Sascha,

On Tue, Oct 15, 2019 at 11:40 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Have you seen https://www.spinics.net/lists/linux-mtd/msg09535.html? I
> think your issue is something else though.

I will test your proposed patch, thanks!
